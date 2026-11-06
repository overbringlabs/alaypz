# Progress

Updated in the same turn as code. This file is the **status head**: the STATE
block below plus the last two dated entries. When an entry ages out of the head,
it moves to `progress/{YYYY-MM}.md` beside this file, unchanged — the journal is the
archive of why, and it is never read at cold start.

Cap: the STATE block stays at or under ~80 lines. If it grows, the oldest
bullets move into the journal; the head answers "where are we", not "how did we
get here".

## In flight

- Plan `plans/20261106_alaypz.md` (7 steps; resequenced for the persistence + views + name-uniqueness requirement) — step 1 (engine core) next. See IN_FLIGHT.md.

## Last completed

- 2026-11-06 — Scope S1–S8 resolved by operator; ruling `decisions/20261106_alaypz_scope.md`; 6-step plan `plans/20261106_alaypz.md`.
- 2026-11-06 — `knowledge/lean-agent-flow/` initialized (ledgers, claim board, journal); AGENTS.md map section appended; `scripts/ledger_budget.sh` wired into `mix precommit` (`ledger.budget` task; gate green, cold start 8.3k / 30k tokens); LiveView 1.2 footguns researched (`research/20261106_liveview12_footguns.md`).

## Needs a decision

- none — scope S1–S8 resolved 2026-11-06.

## In-flight claims

- (see IN_FLIGHT.md; parked = uncommitted and idle, editable)

## Journal

- Older entries: `progress/{YYYY-MM}.md` beside this file (one file per month, newest first inside the month)
