# IN_FLIGHT — live claims board

Whiteboard, not a history ledger. One block per agent, kept beside the status
home. Rewrite your block just before the first edit of a session and again at
every step boundary; delete it (or move paths to `released:`) the moment the
step commits. A claim older than ~15 minutes with no matching fresh write is
stale and may be treated as released; whoever notices deletes the stale line.
Edit only your own block; never another agent's.

## agent: grok-4.6   since: 2026-11-08
released: priv/manifesto.md  (enrich: trade-offs, buy-vs-rent, nanny/classifier, deliberate use)
released: priv/history.md  test/alaypz_web/live/manifesto_live_test.exs  test/alaypz_web/live/history_live_test.exs  knowledge/lean-agent-flow/PROGRESS.md  (MECE rewrite + duplicate H1 fix)

## agent: main   since: 2026-11-06
released: priv/  lib/alaypz_web/  test/alaypz_web/  (/history final text — motivation write-up, placeholder gone — and /manifesto: the local AI manifesto dead view, cave book + footer links)
released: assets/css/  lib/alaypz_web/components/  lib/alaypz_web/live/  (base font size 16→17px root via the central knob; px-literal micro-labels → rem so they scale)
released: assets/css/  priv/static/fonts/  (font swap: Fredoka replaces Arsenal as the UI face — variable 300–700, 2 vendored faces)
released: assets/css/  lib/alaypz_web/live/  priv/static/fonts/  (Arsenal vendored as the UI face — @theme remap, no exceptions; /play: form hidden while a game runs, "Play again" on game over)
released: lib/alaypz_web/  assets/css/  priv/  test/alaypz_web/  mix.exs  mix.lock  (brand round: Overbring footer + logo, ALAYPZ wordmark/title, /history dead view via :mdex from hex, mobile footer hide)
released: (whole-repo)  (Alaypz sweep + namespace rename Alaypz→Alaypz: 86 code/config/doc files, dirs+hooks+docs renamed via git mv, db files mv'd, plan/decision slugs, .gitignore, README)
released: lib/alaypz_web/  assets/js/  assets/css/  (centered maximized tower: gutter in the dead space, compact one-row HUD)
released: lib/alaypz_web/  test/alaypz_web/  assets/js/  assets/css/  (operator round 2: auto-claim, native mobile game screen, tone.js sfx, swipes)
released: lib/alaypz_web/  test/alaypz_web/  assets/js/  (operator round: /u/ rename 7165b65, replay speeds 001103d, /play + mobile controls 8527fdd)
released: lib/alaypz/replay.ex  lib/alaypz_web/  test/alaypz/  test/alaypz_web/  (committed bugfix pass)
released: knowledge/lean-agent-flow/  (UI round 2 ledger; plan steps marked done, 4 commits)
released: lib/alaypz_web/components/score_card.ex  lib/alaypz_web/components/game_card.ex  lib/alaypz_web/components/session_drawer.ex  lib/alaypz_web/components/layouts.ex  lib/alaypz_web/live/lobby_live.html.heex  lib/alaypz_web/live/replay_live.html.heex  assets/css/app.css  (committed step 4)
released: lib/alaypz_web/components/score_card.ex  lib/alaypz_web/components/session_drawer.ex  lib/alaypz_web.ex  lib/alaypz_web/live/leaderboard_live.ex  lib/alaypz_web/live/leaderboard_live.html.heex  lib/alaypz_web/live/lobby_live.ex  lib/alaypz_web/live/lobby_live.html.heex  lib/alaypz_web/live/player_live.html.heex  lib/alaypz_web/live/replay_live.ex  lib/alaypz_web/live/replay_live.html.heex  lib/alaypz_web/router.ex  lib/alaypz/scores/scores.ex  lib/alaypz/replay.ex  assets/js/hooks/alaypz_canvas.js  test/alaypz_web/live/leaderboard_live_test.exs  test/alaypz_web/live/lobby_test.exs  test/alaypz_web/live/replay_live_test.exs  (committed step 3)
released: (none — owner-only control + theme round committed)
released: lib/alaypz/games/game.ex  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/components/game_card.ex  lib/alaypz_web/components/status_chip.ex  lib/alaypz_web/components/controls_legend.ex  lib/alaypz_web/components/layouts.ex  lib/alaypz_web/components/layouts/root.html.heex  lib/alaypz_web/live/lobby_live.ex  lib/alaypz_web/live/lobby_live.html.heex  lib/alaypz_web/live/leaderboard_live.ex  lib/alaypz_web/live/leaderboard_live.html.heex  lib/alaypz_web/live/player_live.html.heex  lib/alaypz_web.ex  assets/js/hooks/alaypz_canvas.js  assets/css/app.css  test/alaypz_web/live/lobby_test.exs  test/alaypz/games_test.exs  knowledge/lean-agent-flow/  (committed UI redesign)
released: lib/alaypz_web/live/lobby_live.html.heex  test/alaypz_web/live/lobby_test.exs  (committed step 7)
released: assets/js/  assets/css/  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/live/lobby_live.ex  lib/alaypz_web/live/lobby_live.html.heex  lib/alaypz_web/live/leaderboard_live.html.heex  lib/alaypz_web/live/player_live.html.heex  lib/alaypz/game.ex  test/alaypz/game_test.exs  test/alaypz_web/live/lobby_test.exs  (committed step 6)
released: lib/alaypz_web/live/leaderboard_live.ex  lib/alaypz_web/live/player_live.ex  lib/alaypz_web/live/leaderboard_live.html.heex  lib/alaypz_web/live/player_live.html.heex  lib/alaypz_web/board.ex  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/router.ex  test/alaypz_web/live/leaderboard_live_test.exs  test/alaypz_web/live/player_live_test.exs  (committed step 5)
released: lib/alaypz_web/live/  lib/alaypz_web/components/game_card.ex  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/router.ex  lib/alaypz/scores/scores.ex  test/alaypz_web/live/lobby_test.exs  (committed step 4)
released: lib/alaypz/games/  lib/alaypz/games.ex  lib/alaypz/application.ex  config/test.exs  test/alaypz/games_test.exs  (committed step 3)
