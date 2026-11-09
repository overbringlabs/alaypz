# deploy/ — production artifacts

Scripts + templates for deploying Alaypz to the deploy host under
`alaypz.overbring.com` (Caddy → `127.0.0.1:7043`; port 4000 is
occupied by another Elixir app on the VPS). Mirrors
`inferyes/deploy/` — the house pattern.

The target host and remote paths are **not committed**: they come from a
local `.deploy.env` at the repo root (copy
`deploy/.deploy.env.example`, gitignored) or exported environment
variables — `DEPLOY_HOST`, `DATA_HOST_DIR`, `ENV_HOST_FILE`,
`DEPLOY_PORT` (defaults to 7043, the app's prod default).

| File | Purpose |
|---|---|
| `deploy.sh` | Workstation → build, rsync, load, restart on the deploy host. Operator-runs, **never the agent**. |
| `entrypoint.sh` | Container CMD: `exec bin/server` (migrations run at release boot — see `Alaypz.Application`). |
| `Containerfile` | Multi-stage prod build (repo root `./Containerfile`). |
| `Caddyfile.snippet` | The site block for the deploy host's `/etc/caddy/Caddyfile`. |
| `alaypz.env.example` | Env-file template. |
| `.deploy.env.example` | Template for the local `.deploy.env` (target host + remote paths). |
| `../rel/overlays/bin/server` | Release overlay: `PHX_SERVER=true` + `bin/alaypz start`. |

## Quick ref

```sh
# One-time: local .deploy.env (gitignored):
cp deploy/.deploy.env.example .deploy.env && $EDITOR .deploy.env

# One-time on the deploy host — env file + data dir:
ssh "$DEPLOY_HOST" 'install -d "$DATA_HOST_DIR" && $EDITOR "$ENV_HOST_FILE"'

# Workstation, from the pinned SHA:
./deploy/deploy.sh

# First health:
ssh "$DEPLOY_HOST" 'curl -fsS localhost:7043/'
curl -fsS https://alaypz.overbring.com/

# Container smoke test (the entrypoint runs as root ON PURPOSE — under
# rootless podman that maps to the deploy user, so the SQLite file on
# the bind-mounted /app/data is writable; `USER nobody` cannot):
ssh "$DEPLOY_HOST" 'podman inspect alaypz --format "{{.State.Health.Status}}"'

# Nightly backup (VACUUM INTO, never copy the live file):
ssh "$DEPLOY_HOST" "sqlite3 $DATA_HOST_DIR/alaypz.db \
  \"VACUUM INTO '/backups/alaypz/alaypz-$(date +%F).db'\""
```

## Rollback

`podman load` replaces `localhost/alaypz:latest` in place, so a rollback
is a redeploy of the previous image tarball from `~/podman-images/`
(keep the previous `.tar` around for one cycle) — the data dir
survives untouched.
