---
id: T-20261106-01
date: 2026-11-06
status: closed
trigger: Operator answers S1–S8 (asked 2026-11-06)
areas: [scope, design]
question: Eight scope decisions for the Alaypz app — rules fidelity, game-loop ownership, spectator freshness, rendering, score persistence, session lifecycle, input, test bar.
---
# Alaypz scope decisions (S1–S8)

Asked to the operator 2026-11-06. **Resolved 2026-11-06**: all eight confirmed —
S1 full classic, S2 server-authoritative, S3 on every change, S4 2D canvas,
S5 server leaderboard + local history, S6 tab-close + 10 s grace with finished
boards kept, S7 keyboard only, S8 engine + LiveView tests.
Ruling: `decisions/20261106_alaypz_scope.md`.

| # | Question | Tension |
|---|---|---|
| S1 | Rules fidelity: classic 10×20 board, SRS rotation with wall kicks, 7-bag randomizer, hold, next-3 queue, ghost piece, level-based gravity, standard scoring (100/300/500/800 × level)? Or a reduced ruleset? | Fidelity vs engine size — SRS + kicks is ~200 lines of pure Elixir, fully unit-testable; a reduced ruleset is simpler but reads as a toy. |
| S2 | Where the game loop runs: server-authoritative (one GenServer per game ticks the board; all inputs are LiveView events) or client-side physics (JS runs the local game, server relays state snapshots)? | Server-authoritative = one engine, trivially observable, but local inputs round-trip over the WebSocket. Client-side = zero-latency local feel, but two engines (JS + Elixir) must agree on rules. |
| S3 | Spectator freshness: broadcast on every state change (immediate, chatty) or snapshot ticks (~10 Hz, compact)? | Defines the latency story: viewers are always ≥ 1 round-trip behind the player. |
| S4 | Rendering: vendored Three.js (WebGL, 3D blocks, lighting) or 2D canvas (gradients, glow, animations)? | Three.js ≈ 600 KB vendored + more code for depth; canvas can look equally striking with far less risk. Aesthetic either way: dark, colorful arcade. |
| S5 | Score persistence: per-browser `localStorage` history only, or a server-side leaderboard (SQLite already scaffolded; names collide, no auth)? | Server leaderboard = a few tables + a controller + the lobby can show all-time bests; localStorage only = zero server surface. |
| S6 | Session lifecycle: when does a game end — tab close, N seconds idle? Do finished games show in the lobby? | Grace period (e.g. 10 s) absorbs reconnects; lobby could show live games plus "recent results". |
| S7 | Input: keyboard only (arrows + space) or mobile touch controls (swipe/tap zones) as well? | Touch adds a whole control surface plus test burden; keyboard-only is the classic. |
| S8 | Test bar: engine unit tests + LiveView tests (lobby, spectator cards, name flow) or engine tests only? | Engine is pure functions — cheap to test; the LiveView layer is covered by `Phoenix.LiveViewTest` + `LazyHTML`. |
