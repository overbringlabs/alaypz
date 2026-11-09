**Alaypz** is a complete web app developed end-to-end with **Qwen 3.8-27B running on local hardware**, one operator round at a time, and it exists because I am annoyed at reading nonsense about local AI models' coding capabilities.

The app includes a deterministic engine, server-authoritative game processes, identity, leaderboards, replays, and a touch UI on mobile viewports. 

Someone on LinkedIn said that this model cannot code. This Elixir / Phoenix LiveView web app is the
rebuttal, because some people won't be convinced about something unless you show it to them; and even then they might shift the goalpost.

It does not matter in the end. Those who want to remain in [the cave](https://leanpub.com/cave) will not let themselves be convinced.

Qwen3.8-27B is great at coding regardless, but you know how to wield it, as with any other tool.

## Built in anger and indignation

The discussion on LinkedIn went a bit like this...

**Isaak:** Qwen3.8-27B-GSQ-RCO-IQ or Ornith-1.5-35B-A3B-MiniPlus-V2.1-IQ2_S, with DeepSeek V4.1 Flash 1017 or Qwen3.8-Flash as the orchestrator. Plus Alibaba's open-code-review. No Claude needed.

**Other guy:** Qwen 3.8 Flash cannot produce great design, code architecture or help smaller models.

**Isaak:** by itself, without any guidance? Not always. With human guidance in the session and with skills / rules? Absolutely. But then again, I am using it to extend a three-codebase product that I had already hand-built and refactored over 2 yea rs, so I'm biasing it. OTOH, it can absolutely review a codebase and suggest refactoring, be told to pursue Domain-Driven Design principles and surface recommendations for refactoring, and it does so without any issues, even on new codebases. As for helping smaller models, it absolutely can. I regularly use it as an orchestrator of Qwen3.8-27B (for unbounded tasks) and Qwen3.5-9B derivatives (for more mechanical, bounded tasks), and it works great. I have Grok 4.6 and DeepSeek V4.1 Flash 1017 review code generated/orchestrated/amended by Qwen3.8-Flash and 27B, and these bigger models' verdicts (plus my own cursory review of the codebase) is why I trust it.

**Other guy:** Even with human guidance, the context is too small.

**Isaak:** That's why you need to use a proper skill that manages the knowledge across "lean indexes" so that you don't blow up the context with unnecessary information. I have also exclusively used the 27B with my "lean-agent-flow" skill (to be open-sourced within the month) to develop 3 Elixir codebases from scratch. Question your assumptions; I'm giving you a data point that disproves them, on a 3-codebase product that was mature already, and has been growing rapidly in recent months by building on a hand-crafted set of code and using Qwen3.8-Flash via Qwen Cloud as the orchestrator, DeepSeek as the reviewer, and Qwen3.8-27B for problem-solving and implementation of subparts. It's been working amazingly well, despite the 262k context of the 27B. You need the right setup to work around the limitations of the 262k context. But once you figure out the right setup, it is entirely workable. And you can also use the 27B as the heavy-lifter, delegating to even smaller models for the boring work -- provided that you have 27B write and adversarially review a thorough plan that's been written with the explicit intent that its parts "will be handed out to dumber subagents that cannot perform well in unbounded tasks".

**Other guy:** The context is 32k :) for machines that cost less than $10k

**Isaak:** The context of the 27B is 262k on a dual-5060 PC with tensor parallelism and an NVFP4 quant and q8_0 symmetric KV cache. It's 131k on a single 16 GB GPU with an APEX quant. 32k? What is this, 2024?

**Other guy:** The whole post is about running LLMs in a Mac Mini - so people don't spend $20k to have a worst version of a $20 subscription (or $200)

**Isaak:** On a Mac Mini, can you not run Ornith-1.5-35B-A3B with decent context, perhaps with a NanoPlus quant?

**Other guy:** It is horrible in building code. Loops, hallucinations, it behaves like someone that learnt programming 6 months ago. Even with Claude as supervisor, it cannot build anything

**Isaak:** Cannot verify, and the only thing I can offer is my own and opposite anecdotal evidence.

**Other guy:** I mean, it is kind of easy to check :D LM Studio, download, "make me Tetris" on a Mac Mini :D

**Isaak:** Yeah but what is the use of this as a benchmark? One-shot, underspecified prompts are a useless proxy for real-world coding performance.

**Other guy:** If it cannot do a Tetris game, I definitely cannot do a real app.

**Isaak:** PEBKAC... not only can Qwen3.8-27B "do a Tetris game", it can do what I'm going to release on Github later today. I let it code overnight, see a screenshot of what it delivered. Phoenix LiveView app with a "live lobby" feature where you can see everyone else's games taking place there, plus a leaderboard with each game's last state. Might add more features, like a game-replay feature.

**Other guy:** overnight? And looks like this? This is from LocalOrca - in 12 minutes (ed. a very nice screenshot). I said "Tetris" as a figure of speech but if it took overnight to make a Tetris game, maybe code it by hand?

**Isaak:** Overnight, because I did not emphasize the game, but the Phoenix LiveView features for live-display of other players' game sessions. It's more than just "Tetris that looks good". A UI polish pass can be done later. Why would I waste my time coding a Tetris game by hand? What kind of benchmark is that anyway? Are you not shifting the goalposts? My point being: you can totally have Qwen3.8-27B develop way more than a toy example with a one-shot prompt. It's been my workhorse for feature expansion and verification of an actual in-production SaaS / web app since August. Three codebases, each one in a different language (NextJS web app and two REST APIs, with the newer REST API strangler-fig-ing the legacy REST API), and it's done a great job, together with alibaba's open-code-review. But do note that all three codebases had been meticulously refactored by hand before I got into agentic coding back in May, and design patterns and architecture have been extensively documented by Qwen3.6-35B-A3B, so the Qwen3.8-27B agent sessions already step on solid ground, even for new features that extend the codebase. You've been telling me that something that I've been doing since May can't be done. Both of us can't be right.

---

This is the proof that both of us can't be right.

## The concept

A neon block-stacker with a deliberately tight product surface: play
your own tower, watch every other game live, keep the history. The
working approach is the whole point of this, i.e. how it was developed exclusively by Qwen3.8-27B.

The choice of game is not important, and it's not central to the software. Substitute any game with ticks, and the same thing can be done for it, by the same model. The game itself is in fact the smaller half of the product. Lobby,
leaderboard, live-spectating any user's game, replaying any game, all that is where architectural judgment gets evaluated. Phoenix
LiveView, WebSockets, PubSub, a GenServer per game, a pure engine
shared with the replays. I did not write any code by hand. I sat in the driver's seat: requirements, a plan, rounds, review. The model did the typing, the implementation of the tests, and the testing after every round.

It took very few turns overall, and the gap between the turns in the timeline below is because I was busy with other things or sleeping, not the actual working time of the model. After the first turn when the game was playable, I started providing more guidance, sometimes sending a screenshot or a
one-line complaint and indication of how I want things fixed. The full
test suite must pass with every `mix precommit` at the end of every turn, and it must look proper using a headless-browser walk for all responsive-design breakpoints from 387 to 1440 px.

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

## What was hard for Qwen3.8-27B

- **The canvas fit measured the layout before it settled** — the claim
  form hid after the hook's first measurement, locking in a tiny board.
  The fix is a re-fit after the layout settles; the gotcha is that the
  page body never resizes under the overflow lock, so the observer has to
  watch the page section instead.
- **An absolutely-positioned gutter anchored to the page, not the board row** — one missing `relative` and the NEXT/HOLD column floats at the
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

- Elixir and Phoenix LiveView.
- One GenServer per active game. 
- A pure engine shared by the game processes and the replays.
- SQLite through Ecto.
- esbuild + Tailwind.
- No `npm`; all JS dependencies are vendored.
- Custom canvas hooks (tweened pieces, neon glow, line flash, sound).
- The board is the touch surface for the mobile viewport.
