# Alaypz — architecture

Alaypz is a Phoenix 1.8 + LiveView demo: a block-stacker game played in the
browser, where a player claims a unique name, plays against the local
`Qwen3.8-27B`-generated content surface, and watches a persistent leaderboard.
No accounts, no sessions, no auth — identity is a claimed name and a
client-side access string.

## Request path

```
Caddy (the deploy host, https://alaypz.overbring.com)
  └─ reverse proxy → 127.0.0.1:7043
      └─ AlaypzWeb.Endpoint (Phoenix, :server in prod via PHX_SERVER)
          ├─ AlaypzWeb.OG          — per-request OpenGraph meta plug
          ├─ AlaypzWeb.Router      — LiveView routes (below)
          └─ AlaypzWeb.Layouts     — app shell: header, flash, footer
```

Routes (`lib/alaypz_web/router.ex`, all `AlaypzWeb.*` LiveViews):

| Path            | LiveView        | Purpose                                  |
|-----------------|-----------------|------------------------------------------|
| `/`             | `LobbyLive`     | claim name, live game cards, session, top scores |
| `/play`         | `PlayLive`      | play the claimed player's game           |
| `/leaderboard`  | `LeaderboardLive` | ranked scores                           |
| `/replay/:id`   | `ReplayLive`    | replay a stored game                     |
| `/why`          | `HistoryLive`   | rendered `priv/history.md` (markdown)    |
| `/u/:player_name` | `PlayerLive`  | a player's games (declared last → unknown names render not-found) |

## Modules

### `Alaypz` domain (`lib/alaypz/`)

- **`Alaypz.Game`** — the pure engine. One struct, no side effects, no
  processes. Board 20×10 (row 0 = top), pieces live in a 4×4 box at `pos`
  with one hidden row above the board; `new/1` builds a deterministic piece
  queue from a seed (7-bag, `bag/1` + `seq`), and inputs are plain functions:
  `move/2`, `rotate/2`, `soft_drop/1`, `hard_drop/1`, `hold/1`, `tick/1`.
  Every client renders the same state via `payload/1`, so a game is fully
  replayable from `(seed, [inputs])` — that's what `/replay` is.
- **`Alaypz.Games`** — the facade: starts and addresses the per-player game
  processes. One game per player at a time, keyed by the player's unique name
  through `Alaypz.Games.Registry` (`Registry`, keyed by name); the processes
  themselves live under `Alaypz.Games.Supervisor` (`DynamicSupervisor`).
  Child ids are unique per start (`name + unique_integer`) because a stopped
  child's slot is released asynchronously and a fixed id would race with it;
  `restart: :temporary` because a game is ended explicitly and must never be
  auto-restarted (a ghost restart would re-take the registry name). Inputs go
  through `input/2` (owner-checked in the child), state snapshots through
  `state/1`, and frames broadcast on the PubSub topic `"game:<name>"`.
- **`Alaypz.Players` / `Alaypz.Scores`** — the two Ecto schemas.
  `players`: `name` (required, ≤ 24 chars, single word, trimmed) + `name_key`
  (downcased, the unique lookup key) + `secret_salt`/`secret_hash` (the
  access-string material — the secret lets a browser elsewhere reclaim the
  name; the name itself is stored client-side). `scores`: one row per game
  result, `has_many` from a player.
- **`Alaypz.Replay`** — derives a replay from a game's recorded inputs
  (seed + action list) rather than storing frames.
- **`Alaypz.Repo`** — Ecto on SQLite via `exqlite` (single file, the
  `DATABASE_PATH` env in prod; `/app/data/alaypz.db` in the container).
- **`Alaypz.Tasks.LedgerBudget`** — the knowledge-ledger token budget
  checker used by `mix precommit`.

### `AlaypzWeb` (`lib/alaypz_web/`)

- **`Endpoint`** — standard; `:server` only when `PHX_SERVER` is set
  (`config/runtime.exs`). The port is `PORT` env, defaulting to 7043 in prod
  (another Elixir app owns 4000 on the host) and 4000 in dev.
- **`OG`** — a plug that emits per-request OpenGraph/canonical meta
  (`og.ex`); the canonical URL is `https://alaypz.overbring.com` in prod
  (`config/prod.exs`), derived from the request in dev/test.
- **`Identity`** — the claim-name flow: name → `Alaypz.Players` → secret
  hash/salt; the access string reclaims the name in another browser.
- **`Markdown`** — renders `priv/history.md` for `/why` (the `.history-prose`
  styles in `app.css` style that body).
- **LiveViews** — `LobbyLive` (streams the live game cards and the session
  panel; subscribes to the game's PubSub topic), `PlayLive` (the board +
  touch controls via the `AlaypzCanvas` hook), `PlayerLive`,
  `LeaderboardLive`, `ReplayLive`, `HistoryLive`.
- **`Telemetry`** — `:telemetry` setup (req/phx/disk/sql) for the dev
  LiveDashboard.

## Supervisor tree (`Alaypz.Application`)

```
AlaypzWeb.Telemetry
Alaypz.Repo
Ecto.Migrator        ← skip: RELEASE_NAME == nil — dev/test skip it (the test
                       alias migrates separately); a release boot (RELEASE_NAME
                       set) runs the pending migrations before the endpoint
                       accepts traffic — schema and image stay in lockstep
DNSCluster           ← multi-node discovery (query from config)
Phoenix.PubSub       (Alaypz.PubSub)
Alaypz.Games.Registry
DynamicSupervisor    (Alaypz.Games.Supervisor — the per-player games)
AlaypzWeb.Endpoint   ← last: it listens only once everything above is up
```

## Frontend

- **Tailwind CSS v4** (`assets/css/app.css`, `@import "tailwindcss"` — no
  config file) + **daisyUI** as a Tailwind plugin with two custom themes:
  `light` (default) and `dark` (neon night; `prefersdark` follows the OS).
  Theme switch = `data-theme` on `<html>`.
- **Vendored fonts** — no CDN: Knewave (display headings, single static 400
  with a declared weight range to stop faux-bold), Manrope (body + prose,
  variable 200–800, latin + latin-ext woff2), Victor Mono (code, variable).
  The `@theme` block remaps `--font-sans`/`--font-mono`/`--font-display`;
  `html { font-size: 18px }` is the one central size knob — everything rem
  scales from it.
- **Colocated JS hooks** (`phx-update`/`phx-hook` colocated in the templates,
  bundled by esbuild into `app.js`): `AlaypzCanvas` (the board renderer —
  canvas, neon palette from `.alaypz-board` custom properties, keyboard +
  touch input, `data-mobile-game` drives the full-viewport game screen on
  phones/portrait tablets) and the `sfx` surface (`window.__alaypz_sfx`).
  No external scripts or inline `<script>` — only the `app.js`/`app.css`
  bundles are served.
- **Mobile invariant**: on `max-width: 1023px` a focused game hides the app
  header *and* footer, zeroes the main padding, and sets `html { overflow:
  hidden }` — the game screen is the viewport and the page can never scroll.

## Data

SQLite, one file. `players` (name, `name_key` unique, `secret_salt`,
`secret_hash`) and `scores` (per-game results, `player_id`). Migrations in
`priv/repo/migrations` run at release boot (see the `Ecto.Migrator` child
above) and via the `test` alias in tests — there is no manual migration step
in the deployment.

## Configuration

| Source               | Purpose                                                        |
|----------------------|----------------------------------------------------------------|
| `config/runtime.exs` | `PHX_SERVER` gate, `PORT` (prod default 7043 / dev 4000), prod env requirements (`DATABASE_PATH`, `SECRET_KEY_BASE`), the dev live-reload patterns |
| `config/prod.exs`    | `force_ssl` (excluding localhost/127.0.0.1), the canonical OG URL |
| env (container)      | `DATABASE_PATH=/app/data/alaypz.db`, `PORT=7043`, `SECRET_KEY_BASE`, `PHX_HOST=alaypz.overbring.com` (from the deploy host's env file — `ENV_HOST_FILE` in `.deploy.env`) |

## Deployment

`deploy/deploy.sh` (run from the repo, by the operator or on explicit
authorization; target host + remote paths from the gitignored `.deploy.env`):
local `podman build` (the `Containerfile` — multi-stage
hexpm/elixir builder → debian slim, `mix release` with `include_build_info`,
a `HEALTHCHECK` on `/`, runs as container root on purpose so the bind-mounted
SQLite file is writable) → `podman save` → `rsync` → `ssh $DEPLOY_HOST`
`podman load` + `podman run -d --network host -v $DATA_HOST_DIR:/app/data:Z
-e DATABASE_PATH=/app/data/alaypz.db -e PORT=7043 --env-file $ENV_HOST_FILE`.
`deploy/entrypoint.sh` is just `exec ./bin/server` (migrations happen at boot
— see the supervisor tree). Caddy on the deploy host terminates TLS at
`https://alaypz.overbring.com` and proxies to `127.0.0.1:7043`. Rollback =
redeploy the previous image tarball from `~/podman-images/`; the data dir
survives untouched.

## Testing

`MIX_ENV=test mix test` — 89 tests (ex_unit, `start_supervised!` for
processes, `Process.monitor`/DOWN over sleeps). `mix precommit` is the gate:
format + tests + the ledger budget.

## Conventions

- `Req` for outbound HTTP (no `:httpoison`/`:tesla`/`:httpc`).
- LiveView streams for collections; `phx-update="ignore"` + unique DOM ids for
  JS hooks; unique DOM ids on forms and key elements (tests reference them).
- The zero-mention gate: the legacy product names must not appear in the
  working tree, new files, or commit messages (the app is "Alaypz").
