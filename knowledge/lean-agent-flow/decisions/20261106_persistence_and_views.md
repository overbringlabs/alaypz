---
id: D-20261106-02
date: 2026-11-06
status: standing
areas: [scope, persistence, naming]
question: Persisting game outcomes, leaderboard and per-player views, and the duplicate-name rule
---
# Game persistence, leaderboard views, name uniqueness (added 2026-11-06)

Operator requirement 2026-11-06, layered on S1–S8.

## Persistence

- When a game ends (top-out) **or** its session is interrupted (disconnect past
  the 10 s grace), the final state is persisted: player name, score, lines,
  level, end reason (`finished` / `interrupted`), final board, timestamps.
- Persisted game rows are the source for the views below. A reconnect within
  the grace period resumes the game and persists nothing.

## Views

- `GET /leaderboard` — past games, top 10 by score descending; each entry
  shows player, score, end reason, ended-at, and the final board drawn from
  the persisted state.
- `GET /:player_name` — that player's games, score descending; unknown name →
  not-found state. Declared after the specific routes so `/` and
  `/leaderboard` match first; it also turns unknown paths into the not-found
  state.

## Name uniqueness (the operator's dilemma, resolved as a hybrid)

- Default: the entered name is validated against the database; duplicates are
  rejected (first-come-first-served).
- Override: when a name is claimed, a **20-char access string is shown once**;
  only its salted hash is persisted (per-row salt, SHA-256, timing-safe
  verify — stdlib `:crypto`, no new dependency).
- Reclaim: a duplicate submitter may enter the access string; a match
  reclaims the name (same identity). Wrong string → rejected.
- Position: the two presented options are complements, not alternatives —
  "override the duplicate-detection" only makes sense if the detection
  exists. Reversible: dropping the reclaim path leaves plain uniqueness.
- The access string is not auto-stored anywhere client-side: it is the
  off-browser credential that makes reclaim meaningful.
