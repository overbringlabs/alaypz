# Multi-stage production build for Alaypz.
#
# Based on the inferyes Containerfile (the house pattern): same builder /
# runner images, the tailwind curl workaround, and a migrate-then-serve
# entrypoint. Differences: the Tailwind version mirrors config/config.exs
# (4.3.3), the healthcheck probes "/" (alaypz has no /health route; the
# lobby answers 200), and the default PORT is 7043 (the VPS runs another
# Elixir app on 4000).
#
# Images:
#   builder: https://hub.docker.com/r/hexpm/elixir/tags
#   runner:  https://hub.docker.com/_/debian/tags
#
# Debian (not Alpine) to avoid production compatibility issues (DNS
# resolution, dynamically linked NIFs).
ARG ELIXIR_VERSION=1.20.4
ARG OTP_VERSION=29.1.1
ARG DEBIAN_VERSION=trixie-20261005-slim

ARG BUILDER_IMAGE="docker.io/hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="docker.io/debian:${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} AS builder

# The commit the image is built from. `deploy/deploy.sh` passes it.
ARG GIT_COMMIT=unknown

# install build dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential git cmake curl \
  && rm -rf /var/lib/apt/lists/*

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force \
  && mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"
ENV GIT_COMMIT="${GIT_COMMIT}"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

# The tailwind package fetches its CLI with :httpc, whose header limit
# (10 KiB) GitHub's redirect response exceeds (`header_too_long`). Fetch
# the same release artifact with curl into the path
# `tailwind.install --if-missing` checks.
# Version mirrors `config :tailwind, version:` in config/config.exs.
ARG TAILWIND_VERSION=4.3.3
RUN mkdir -p /app/_build \
  && curl -fsSL -o "/app/_build/tailwind-linux-x64-${TAILWIND_VERSION}" \
     "https://github.com/tailwindlabs/tailwindcss/releases/download/v${TAILWIND_VERSION}/tailwindcss-linux-x64" \
  && chmod +x "/app/_build/tailwind-linux-x64-${TAILWIND_VERSION}"

RUN mix assets.setup

COPY priv priv

COPY lib lib

# Compile the release
RUN mix compile

COPY assets assets

# compile assets
RUN mix assets.deploy

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

COPY rel rel
RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE} AS final

RUN apt-get update \
  && apt-get install -y --no-install-recommends libstdc++6 openssl libncurses6 locales ca-certificates curl \
  && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
  && locale-gen

ARG GIT_COMMIT=unknown

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV GIT_COMMIT="${GIT_COMMIT}"

WORKDIR "/app"

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=builder /app/_build/${MIX_ENV}/rel/alaypz ./

# migrate-then-serve for the single-node SQLite deployment (deploy/README.md)
COPY deploy/entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Runs as container root ON PURPOSE: under rootless podman (the DEPLOY_HOST model,
# same as inferyes) that maps to the deploy user on the host, so the SQLite
# file on the bind-mounted /app/data is writable. `USER nobody` cannot write
# a host-owned data dir and dies with database_open_failed.

# Loopback health probe (force_ssl excludes 127.0.0.1); shell form so the
# runtime PORT is honoured. alaypz has no /health route — the lobby answers.
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD curl -fsS "http://127.0.0.1:${PORT:-7043}/" || exit 1

# migrate-then-serve so schema and image stay in lockstep on each start
CMD ["/app/entrypoint.sh"]
