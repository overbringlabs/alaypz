#!/bin/bash
# Deploy Alaypz: build, save, rsync, load, run. Mirrors
# inferyes/deploy/deploy.sh — the house pattern.
#
# OPERATOR-RUNS, NEVER THE AGENT. Podman, host networking, one replica.
# The container runs migrate-then-serve (Containerfile CMD ->
# entrypoint.sh), so schema and image stay in lockstep; there is no
# separate migration job. Caddy on the deploy host reverse-proxies
# https://alaypz.overbring.com to 127.0.0.1:7043 (Caddyfile.snippet);
# port 7043 because 4000 is occupied by another Elixir app on the VPS.
#
# Target host + remote paths come from the local .deploy.env (NOT
# committed) or the environment: DEPLOY_HOST, DATA_HOST_DIR,
# ENV_HOST_FILE, DEPLOY_PORT (see deploy/.deploy.env.example).
set -e

IMAGE=alaypz
CONTAINER=alaypz
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
[ -f "$SCRIPT_DIR/../.deploy.env" ] && . "$SCRIPT_DIR/../.deploy.env"
: "${DEPLOY_HOST:?set DEPLOY_HOST in .deploy.env (see deploy/.deploy.env.example)}"
: "${DATA_HOST_DIR:?set DATA_HOST_DIR in .deploy.env}"
: "${ENV_HOST_FILE:?set ENV_HOST_FILE in .deploy.env}"
# The port Caddy reverse-proxies to — must match the Caddyfile snippet on
# the deploy host. Defaults to the app's prod default (config/runtime.exs).
DEPLOY_PORT="${DEPLOY_PORT:-7043}"

# 1. Build locally (--format docker preserves HEALTHCHECK under Podman).
# The git commit is baked in as a build arg.
COMMIT="$(git rev-parse HEAD 2>/dev/null || echo unknown)"
VERSION="$(sed -n -E 's/^ *version: "([0-9]+\.[0-9]+\.[0-9]+)",$/\1/p' mix.exs | head -1)"
[ -n "$VERSION" ] || VERSION="unknown"
echo "building alaypz v${VERSION} (${COMMIT:0:7})"

podman build --format docker --rm -t "$IMAGE" \
  --build-arg GIT_COMMIT="$COMMIT" .

# 2. Save and sync the tarball
rm -f "$IMAGE.tar"
podman save "$IMAGE" -o "$IMAGE.tar"
rsync -arvhzuP "$IMAGE.tar" "${DEPLOY_HOST}:~/podman-images/"
rm -f "$IMAGE.tar"

# 3. Remote: stop/rm old, load new, run. --network host so caddy reaches
#    it on 127.0.0.1:$DEPLOY_PORT (deploy.sh passes PORT explicitly). :Z
#    relabels the volume. restart=always is the single-node guarantee.
ssh "${DEPLOY_HOST}" bash -c "$(printf '%s\n' \
  'set -e' \
  "podman stop ${CONTAINER} || true" \
  "podman rm ${CONTAINER} || true" \
  "podman load -i ~/podman-images/${IMAGE}.tar" \
  "echo '--- Starting ${CONTAINER} ---'" \
  "podman run -d --name ${CONTAINER} --restart always --network host \
     -v ${DATA_HOST_DIR}:/app/data:Z \
     -e DATABASE_PATH=/app/data/alaypz.db \
     -e PORT=${DEPLOY_PORT} \
     --env-file ${ENV_HOST_FILE} \
     localhost/${IMAGE}:latest" \
  'podman image prune -f' \
)"

# 4. Local cleanup
podman rmi "localhost/${IMAGE}:latest"

echo "deployed. verify:"
echo "  ssh ${DEPLOY_HOST} 'curl -fsS localhost:${DEPLOY_PORT}/'"
echo "  curl https://alaypz.overbring.com/"
