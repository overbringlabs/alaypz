# Plan — UI redesign (2026-11-06, operator ask)

Scope: strip the `phx.new` boilerplate design (header, theme toggle, light theme),
give the LiveViews a consistent neon-arcade look, add discoverable key hints,
and make the lobby show **every ongoing game live** — each card renders its own
mini-canvas (no click needed to see a game); clicking a card focuses it into the
large "game session" surface at proper size (existing `FocusedGame` panel).

## Steps

| # | Step | Write-set | Deps | Status |
|---|---|---|---|---|
| 1 | Live cards: `lobby` broadcast carries the full payload; `GameCard` renders a `.AlaypzCanvas` mini-board (new "card" mode: 10 px cells, no band, `alaypz-card-frame` events filtered by `data-name`); card = name + status chip + score; focus highlight | `lib/alaypz/games/game.ex` `lib/alaypz_web/components/{game_card,focused_game}.ex` `assets/js/hooks/alaypz_canvas.js` `lib/alaypz_web/live/lobby_live.ex` | — | done (2026-11-06) |
| 2 | Lobby template: sections (identity, live games, focused session, recent results), empty states, focus toggle (card click = focus, click again or Unfocus = unfocus), key-hint legend in the focused panel and in the layout header | `lib/alaypz_web/live/lobby_live.html.heex` `lib/alaypz_web/live/lobby_live.ex` | 1 | done (2026-11-06) |
| 3 | Boilerplate out: `Layouts.app` header (wordmark + controls legend + leaderboard link), `theme_toggle` removed, `root.html.heex` theme script removed, dark-only design; `app.css` design system (body glow, wordmark, `.kbd`, card/status styles); `/leaderboard` + `/:player_name` restyled (rank glow, hover) | `lib/alaypz_web/components/layouts.ex` `lib/alaypz_web/components/layouts/root.html.heex` `assets/css/app.css` `lib/alaypz_web/live/{leaderboard,player}_live.html.heex` | 1 | done (2026-11-06) |
| 4 | Verify: tests (card canvas, focus toggle, unfocus, payload in lobby message), `mix test`, `mix format`, `--warnings-as-errors`, browser smoke (cards live without click, click-to-focus at proper size, unfocus, keys, `/leaderboard` + `/:name`), `mix precommit`, ledger, commit | `test/alaypz_web/live/lobby_test.exs` + ledger | 1–3 | done (2026-11-06) |

## Status

- 2026-11-06: plan written after operator request (post step-7 of `20261106_alaypz.md`).
- 2026-11-06: **All steps done.** New shared components: `AlaypzWeb.StatusChip` (state pill) + `AlaypzWeb.ControlsLegend` (kbd-chip key hints, compact strip + labeled rows) — both `use Phoenix.Component` directly (a `use AlaypzWeb, :html` self-import cycle fails: `html_helpers` imports them). `lobby` broadcast now carries the full payload; `GameCard` pushes `alaypz-card-frame` (name-filtered, `data-name`) to its 100×200 mini-canvas (`.AlaypzCanvas` card mode: 10 px cells, no band, no tween/flash); card click toggles focus (the `start` event focuses too, so a start-then-card-click cycle unfocuses — verified in the smoke); the focused session renders at `data-cell="28"` (280×616) with the controls panel and Unfocus button; `FocusedGame.frame/2` is public and shared. Boilerplate stripped: phx.new header/theme-toggle/theme-script/light-theme removed; neon wordmark + body glow + `.kbd` chips; `/leaderboard` rank glow (gold/silver/bronze) + hover rows; names link to `/:player_name`. Bugs found: HEEx class lists need the closing `]` before `}` (two TokenMissingErrors); `@actions` module attributes are not visible inside `~H` (assigns shadow them) — pass via `assign_new`; `attr` defaults are not injected at imported-function call sites — apply `Map.put_new(:class, "")` in the function. Browser smoke: card canvas live without a click (piece moved `[3,2]→[3,3]` across frames), spectator tab renders the same live card, click-to-focus (280×624, card highlight + "focused" badge), toggle-off + Unfocus button, keys act on the focused game, finished cards keep their final board (dimmed, "finished" chip), `/leaderboard` 6 lit canvases, `/ui-smoke` + unknown-name not-found state, zero console errors in both tabs. 61 repo tests green; `mix precommit` green.

## Notes

- Cards render their own canvas (the plan doc for the alaypz app already anticipated
  "mini-canvases via the same .AlaypzCanvas hook scaled down"). The `lobby` topic
  becomes the frame channel for cards (every lobby view shows all cards); the
  `game:<name>` topic stays the channel for the focused surface.
- `FocusedGame.frame/2` becomes public (shared frame builder for card + focused frames).
- Card click toggles focus; the focused panel has an explicit Unfocus button.
- Key hints: compact legend in the layout header (all pages) + a full controls
  panel in the focused section (kbd chips per action).
