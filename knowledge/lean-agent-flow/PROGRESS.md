# Progress

Updated in the same turn as code. This file is the **status head**: the STATE
block below plus the last two dated entries. When an entry ages out of the head,
it moves to `progress/{YYYY-MM}.md` beside this file, unchanged — the journal is the
archive of why, and it is never read at cold start.

Cap: the STATE block stays at or under ~80 lines. If it grows, the oldest
bullets move into the journal; the head answers "where are we", not "how did we
get here".

## In flight

- Plan `plans/20261106_alaypz.md` (7 steps; resequenced for the persistence + views + name-uniqueness requirement) — step 3 (game process) next. See IN_FLIGHT.md.

## Last completed

- 2026-11-06 — Plan step 2 (identity & persistence): `Alaypz.Players` (unique `name_key`, salted SHA-256 access-string hash, claim/reclaim, 20-char generator, constant-time compare) + `Alaypz.Scores` (final-state rows, 200-char board encoding, top-10/per-player queries) + migrations; 12 tests, 38 repo-wide green; lesson L-20261106-01 (OTP 29/Ecto 3.14 API drift).
- 2026-11-06 — Plan step 1 (engine core): `lib/alaypz/game/**` — SRS + 7-bag + hold + ghost + guideline gravity + scoring + top-out, 21 unit tests green, kick tables cross-checked against community SRS spec.
- 2026-11-06 — Scope S1–S8 resolved by operator; ruling `decisions/20261106_alaypz_scope.md`; plan `plans/20261106_alaypz.md`.
- 2026-11-06 — `knowledge/lean-agent-flow/` initialized (ledgers, claim board, journal); AGENTS.md map section appended; `scripts/ledger_budget.sh` wired into `mix precommit` (`ledger.budget` task; gate green, cold start 8.3k / 30k tokens); LiveView 1.2 footguns researched (`research/20261106_liveview12_footguns.md`).

## Needs a decision

- none — scope S1–S8 resolved 2026-11-06.

## In-flight claims

- (see IN_FLIGHT.md; parked = uncommitted and idle, editable)

## Journal

- Older entries: `progress/{YYYY-MM}.md` beside this file (one file per month, newest first inside the month)
