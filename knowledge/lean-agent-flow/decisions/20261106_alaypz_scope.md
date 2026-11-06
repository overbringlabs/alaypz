---
id: D-20261106-01
date: 2026-11-06
status: standing
areas: [scope, design]
question: The eight scope rulings for the Alaypz app (S1–S8)
---
# Alaypz scope (S1–S8)

Confirmed by the operator 2026-11-06 (original questions:
`todo/20261106_scope_decisions.md`).

| # | Ruling |
|---|---|
| S1 | Full classic rules: 10×20 board, SRS rotation with wall kicks, 7-bag randomizer, hold, next-3 queue, ghost piece, level-based gravity, standard scoring (100/300/500/800 × level). |
| S2 | Server-authoritative loop: one Elixir process per game; every client (player and spectators) renders the pushed state; inputs are LiveView events. |
| S3 | Spectator updates on every change (score / name / board); the canvas tweens between the last two server states to hide one round-trip. |
| S4 | 2D canvas rendering, colorful dark neon arcade aesthetic; no Three.js. |
| S5 | Server leaderboard (SQLite, keyed by name) shown in the lobby, plus per-browser `localStorage` session history. |
| S6 | Session ends on tab close with a 10 s grace (reconnect resumes the game); a finished board stays visible in the lobby until the player leaves; rematch restarts it. |
| S7 | Keyboard only: arrows + space. |
| S8 | Engine unit tests plus `Phoenix.LiveViewTest` coverage of the lobby, spectator cards, and the name flow. |
