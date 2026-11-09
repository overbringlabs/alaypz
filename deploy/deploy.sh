#!/bin/bash
# Deploy Alaypz to DEPLOY_HOST.overbring.com: build, save, rsync,
# load, run. Mirrors inferyes/deploy/deploy.sh — the house pattern.
#
# OPERATOR-RUNS, NEVER THE AGENT. Podman, host networking, one replica.
# The container runs migrate-then-serve (Containerfile CMD ->
# entrypoint.sh), so schema and image stay in lockstep; there is no
# separate migration job. Caddy on DEPLOY_HOST reverse-proxies
# https://alaypz.overbring.com to 127.0.0.1:7043 (Caddyfile.snippet);
# port 7043 because 4000 is occupied by another Elixir app on the VPS.
#
# First run: create the env file and data dir on DEPLOY_HOST (see alaypz.env.example),
#   ssh DEPLOY_HOST.overbring.com 'install -d /home/DEPLOY_USER/apps_data/alaypz && \
#                          $EDITOR /home/DEPLOY_USER/alaypz.env'
set -e

IMAGE=alaypz
CONTAINER=alaypz
DEPLOY_HOST="DEPLOY_HOST.overbring.com"
DATA_HOST_DIR="/home/DEPLOY_USER/apps_data/alaypz"
ENV_HOST_FILE="/home/DEPLOY_USER/alaypz.env"

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
#    it on 127.0.0.1:7043 (deploy.sh passes PORT=7043 explicitly). :Z
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
     -e PORT=7043 \
     --env-file ${ENV_HOST_FILE} \
     localhost/${IMAGE}:latest" \
  'podman image prune -f' \
)"

# 4. Local cleanup
podman rmi "localhost/${IMAGE}:latest"

echo "deployed. verify:"
echo "  ssh ${DEPLOY_HOST} 'curl -fsS localhost:7043/'"
echo "  curl https://alaypz.overbring.com/"
