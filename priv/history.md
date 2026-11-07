# How this was built

Alaypz is a local AI experiment: a complete web product — deterministic
engine, server-authoritative game processes, identity, leaderboards,
replays, a mobile-first interface — developed end-to-end with **Qwen
3.8-27B running on local hardware**, one operator round at a time.

## Why

People who have spent the past year and a half using cloud frontier models
exclusively have a badly distorted picture of what local models can do
now — Plato's cave, mistaking shadows for the world. And the usual way of
settling the argument — "build me a clone of that popular game" in one
underspecified prompt — does not measure coding ability at all: it
measures how much of the training data you are paying to get
regurgitated, with the operator reduced to a meat proxy.

The real value of a local model is an experienced collaborator, with the
operator in the driver's seat: requirements, specification, architecture,
many rounds. In this codebase the game matters less than the system
around it — the lobby, the leaderboard, live-spectating any user's game,
replaying any game. That is where the model's architectural judgment gets
evaluated.

This was built as a rebuttal: someone on LinkedIn claimed that Qwen
3.8-27B cannot code. Since May (Qwen 3.6), and since August with Qwen
3.8, multiple codebases have been developed this way — the operator in
the driver's seat, not hoping the model reads their mind. If you want to
understand the stakes behind that, read
[The Cave](https://overbring.com/books/cave/); if you want the
unfiltered version of this section, [read the manifesto](/manifesto).

## The concept

A neon block-stacker with a deliberately tight product surface: play your
own tower, watch every other game live, keep the history. The working
method is the point — the operator sends a screenshot or a one-line
complaint, and the next version is running in the browser moments later.
The invariant every round must leave green: the full test suite, plus a
real-browser size matrix from 387 to 1440 px.

## Timeline (from the session logs)

| When (UTC) | What happened |
| --- | --- |
| Nov 6, ~04:30 | the seven-step plan finished: pure engine (SRS wall kicks, deterministic 7-bag, hold, ghost, gravity, scoring), identity with one-time access-string reclaim, one GenServer per game, lobby with live mini-canvas cards, canvas rendering, history views, polish |
| Nov 6, 16:00 | operator round: auto-claim on return, native mobile game screen, sound effects, swipe gestures |
| Nov 6, 16:40 | tablet fix — the 768–1024 px breakpoint gap that rendered desktop chrome on a portrait tablet |
| Nov 6, 18:20 | swipe-only: the button pad is gone, the board itself is the touch surface |
| Nov 6, 20:05 | full-bleed: the card-inside-a-card is gone, NEXT/HOLD sit in a side gutter |
| Nov 6, 20:40 | never-scroll: settle-aware fit + a viewport overflow lock |
| Nov 6, 21:00 | the tower centered and maximized to the viewport |
| Nov 7, ~00:05 | brand sweep: the old product name purged from every file, namespace renamed to Alaypz |
| Nov 7, 01:30 | history surgery: the old names removed from every object of the rewritten commit history |

Wall clock: **Nov 5 23:29 → Nov 7 01:52 UTC** — about 26 hours across two
work sessions and one overnight break; **37 operator prompts**, most of
them a screenshot and a sentence.

## What was hard

- **The canvas fit measured the layout before it settled** — the claim
  form hid after the hook's first measurement, locking in a tiny board.
  The fix is a re-fit after the layout settles; the gotcha is that the
  page body never resizes under the overflow lock, so the observer has to
  watch the page section instead.
- **An absolutely-positioned gutter anchored to the page, not the board
  row** — one missing `relative` and the NEXT/HOLD column floats at the
  viewport edge.
- **Focus is process-global across tabs** on the shared dev server: a
  second tab silently drops the first tab's inputs.
- **LiveView 1.2 footguns** — pushing events from a component's update
  path, `send_update` taking no socket, `cond` clauses needing real
  booleans.
- **Ecto/OTP 29 API drift** — `validate_unique` gone,
  `:crypto.timing_safe_match` missing, changeset errors arriving as
  message-and-options tuples.
- **A spectator could drive another player's game** — the review pass
  found the missing ownership gate; fixed at three layers, so the game
  process only accepts the attached owner's pid.

## Stack

Elixir + Phoenix LiveView · one GenServer per active game · a pure engine
shared by the game processes and the replays · SQLite through Ecto ·
esbuild + Tailwind (no npm) · custom canvas hooks (tweened pieces, neon
glow, line flash, sound) · the board is the touch surface.
