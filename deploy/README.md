# deploy/ — production artifacts

Scripts + templates for deploying Alaypz to `DEPLOY_HOST.overbring.com` under
`alaypz.overbring.com` (Caddy → `127.0.0.1:7043`; port 4000 is
occupied by another Elixir app on the VPS). Mirrors
`inferyes/deploy/` — the house pattern.

| File | Purpose |
|---|---|
| `deploy.sh` | Workstation → build, rsync, load, restart on DEPLOY_HOST. Operator-runs, **never the agent**. |
| `entrypoint.sh` | Container CMD: `bin/migrate` (idempotent) then `bin/server`. |
| `Containerfile` | Multi-stage prod build (repo root `./Containerfile`). |
| `Caddyfile.snippet` | The site block for DEPLOY_HOST's `/etc/caddy/Caddyfile`. |
| `alaypz.env.example` | Env-file template. |
| `../rel/overlays/bin/server` | Release overlay: `PHX_SERVER=true` + `bin/alaypz start`. |

## Quick ref

```sh
# First run — env file + data dir on DEPLOY_HOST:
ssh DEPLOY_HOST.overbring.com 'install -d /home/DEPLOY_USER/apps_data/alaypz && \
                       $EDITOR /home/DEPLOY_USER/alaypz.env'

# Workstation, from the pinned SHA:
./deploy/deploy.sh

# First health:
ssh DEPLOY_HOST.overbring.com 'curl -fsS localhost:7043/'
curl -fsS https://alaypz.overbring.com/

# Container smoke test (the entrypoint runs as root ON PURPOSE — under
# rootless podman that maps to the deploy user, so the SQLite file on
# the bind-mounted /app/data is writable; `USER nobody` cannot):
ssh DEPLOY_HOST.overbring.com 'podman inspect alaypz --format "{{.State.Health.Status}}"'

# Nightly backup (VACUUM INTO, never copy the live file):
sqlite3 /home/DEPLOY_USER/apps_data/alaypz/alaypz.db \
  "VACUUM INTO '/backups/alaypz/alaypz-$(date +%F).db'"
```

## Rollback

`podman load` replaces `localhost/alaypz:latest` in place, so a rollback
is a redeploy of the previous image tarball from `~/podman-images/`
(keep the previous `.tar` around for one cycle) — the data dir
survives untouched.
