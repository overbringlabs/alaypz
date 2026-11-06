# IN_FLIGHT — live claims board

Whiteboard, not a history ledger. One block per agent, kept beside the status
home. Rewrite your block just before the first edit of a session and again at
every step boundary; delete it (or move paths to `released:`) the moment the
step commits. A claim older than ~15 minutes with no matching fresh write is
stale and may be treated as released; whoever notices deletes the stale line.
Edit only your own block; never another agent's.

## agent: main   since: 2026-11-06
writing: lib/alaypz_web/live/  lib/alaypz_web/router.ex  test/alaypz_web/live/
next:    plan step 4 (lobby LiveView + router) — plans/20261106_alaypz.md
released: lib/alaypz/games/  lib/alaypz/games.ex  lib/alaypz/application.ex  config/test.exs  test/alaypz/games_test.exs  (committed step 3)
