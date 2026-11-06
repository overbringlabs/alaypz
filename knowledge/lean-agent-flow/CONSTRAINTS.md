# CONSTRAINTS — index of given boundaries

Constraints are not choices: laws, external contracts, capacity, standing owner
limits — what shrinks the feasible set. State them at the edge; design freely
inside. Bodies live in `constraints/{YYYYMMDD}_{slug}.md`, beside this index; a changed constraint
gets a new dated entry (constraints are history too).

## 2026-11-06 — No npm; JS dependencies vendored
- Constraint: no npm/npx. JS dependencies are vendored into `assets/vendor/` and imported from `assets/js/app.js` (or `app.css`).
- Source / owner: operator brief 2026-11-06; repo AGENTS.md.
- Binds: all frontend work, including any 3D library.

## 2026-11-06 — No authentication
- Constraint: no auth system; a player is an anonymous browser whose identity is the name in `localStorage`; a server session is a transient LiveView connection.
- Source / owner: operator brief 2026-11-06.
- Binds: lobby, session, and leaderboard design.

## 2026-11-06 — Bundles and hooks only
- Constraint: only the `app.js`/`app.css` bundles; no inline `<script>`; JS interop via colocated hooks (`.Name`) or external `phx-hook` registered in app.js.
- Source / owner: repo AGENTS.md (phx.new v1.8).
- Binds: game canvas rendering (hook + `push_event`).

## 2026-11-06 — Elixir toolchain via mise
- Constraint: elixir 1.20.4-otp-29 / erlang 29.1.1 via mise; agent shells run all `mix` commands through `mise exec --`.
- Source / owner: `mise.toml`; elixir-mise skill.
- Binds: all build / test / compile commands.
