# IN_FLIGHT — live claims board

Whiteboard, not a history ledger. One block per agent, kept beside the status
home. Rewrite your block just before the first edit of a session and again at
every step boundary; delete it (or move paths to `released:`) the moment the
step commits. A claim older than ~15 minutes with no matching fresh write is
stale and may be treated as released; whoever notices deletes the stale line.
Edit only your own block; never another agent's.

## agent: main   since: 2026-11-06
writing: (none — owner-only control + theme round committed)
next:    — (no active plan)
released: lib/alaypz/games/game.ex  lib/alaypz/games.ex  lib/alaypz_web/live/lobby_live.ex  lib/alaypz_web/live/lobby_live.html.heex  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/components/layouts.ex  lib/alaypz_web/components/layouts/root.html.heex  assets/css/app.css  test/alaypz/games_test.exs  test/alaypz_web/live/lobby_test.exs  knowledge/lean-agent-flow/  (committed owner-only control + theme round)
released: lib/alaypz/games/game.ex  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/components/game_card.ex  lib/alaypz_web/components/status_chip.ex  lib/alaypz_web/components/controls_legend.ex  lib/alaypz_web/components/layouts.ex  lib/alaypz_web/components/layouts/root.html.heex  lib/alaypz_web/live/lobby_live.ex  lib/alaypz_web/live/lobby_live.html.heex  lib/alaypz_web/live/leaderboard_live.ex  lib/alaypz_web/live/leaderboard_live.html.heex  lib/alaypz_web/live/player_live.html.heex  lib/alaypz_web.ex  assets/js/hooks/alaypz_canvas.js  assets/css/app.css  test/alaypz_web/live/lobby_test.exs  test/alaypz/games_test.exs  knowledge/lean-agent-flow/  (committed UI redesign)
released: lib/alaypz_web/live/lobby_live.html.heex  test/alaypz_web/live/lobby_test.exs  (committed step 7)
released: assets/js/  assets/css/  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/live/lobby_live.ex  lib/alaypz_web/live/lobby_live.html.heex  lib/alaypz_web/live/leaderboard_live.html.heex  lib/alaypz_web/live/player_live.html.heex  lib/alaypz/game.ex  test/alaypz/game_test.exs  test/alaypz_web/live/lobby_test.exs  (committed step 6)
released: lib/alaypz_web/live/leaderboard_live.ex  lib/alaypz_web/live/player_live.ex  lib/alaypz_web/live/leaderboard_live.html.heex  lib/alaypz_web/live/player_live.html.heex  lib/alaypz_web/board.ex  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/router.ex  test/alaypz_web/live/leaderboard_live_test.exs  test/alaypz_web/live/player_live_test.exs  (committed step 5)
released: lib/alaypz_web/live/  lib/alaypz_web/components/game_card.ex  lib/alaypz_web/components/focused_game.ex  lib/alaypz_web/router.ex  lib/alaypz/scores/scores.ex  test/alaypz_web/live/lobby_test.exs  (committed step 4)
released: lib/alaypz/games/  lib/alaypz/games.ex  lib/alaypz/application.ex  config/test.exs  test/alaypz/games_test.exs  (committed step 3)
