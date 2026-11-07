# Alaypz

A neon block-stacker: one deterministic engine, server-authoritative game
processes, and live canvases everywhere — play your own tower on `/play`,
watch every other game live from the lobby, and replay any recorded game.

## Routes

| Route | Surface |
| --- | --- |
| `/` | Lobby: identity claim, live mini-canvas cards for every ongoing game (spectate without clicking), focused live surface, top recent scores with final boards |
| `/play` | Your game: keyboard on desktop, the board itself is the touch surface on mobile (swipe to move, flick down to drop, flick up to rotate, press-and-hold to hold) |
| `/leaderboard` | Top 10 by score, final boards drawn, session drawer with data + replay link |
| `/u/:player_name` | A player's game history (score desc, final boards) |
| `/replay/:id` | Deterministic replay of a recorded game, 1x–100x |

Identity: claim a unique name, the server shows a one-time 20-char access
string (only a salted hash is stored); losing the name is reclaimed by
presenting that string.

## Getting started

Toolchains (Elixir/Erlang) are pinned in `mise.toml`:

```sh
mise install
mise exec -- mix setup
mise exec -- mix phx.server        # http://localhost:4000
```

* Tests: `MIX_ENV=test mise exec -- mix test`
* Precommit gate (format + tests + ledger budget): `mise exec -- mix precommit`

Assets are built by esbuild + Tailwind v4 through Elixir deps — no npm.
The database is SQLite: `alaypz_dev.db` / `alaypz_test.db` at the repo
root (gitignored, created on first migrate).

## Shape

* **`Alaypz.Game`** — pure engine: SRS rotation + wall kicks,
  deterministic 7-bag, hold, ghost, gravity, scoring, top-out. No side
  effects; the same dispatch drives the game processes and replays.
* **`Alaypz.Games`** — one GenServer per active game: server-authoritative
  tick loop, PubSub broadcasts on every change (spectators see the same
  frames as the player), owner attach with a reconnect grace window, final
  state persisted on end/interrupt.
* **`Alaypz.Players` / `Alaypz.Scores`** — identity (unique name, salted
  SHA-256 access-string hash, constant-time compare) and score rows
  (final board + seed/tick recording for replays).
* **`AlaypzWeb`** — LiveView surfaces: lobby, play, leaderboard, player
  history, replay stepper; canvas hooks (tweened pieces, neon glow, line
  flash, sfx) and the swipe-gesture hook on the client.
