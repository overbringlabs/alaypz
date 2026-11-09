**Alaypz** is a complete web app developed end-to-end with **Qwen 3.8-27B running on local hardware**, one operator round at a time, and it exists because I am annoyed at reading nonsense about local AI models' coding capabilities.

The app includes a deterministic engine, server-authoritative game processes, identity, leaderboards, replays, and a touch UI on mobile viewports. 

Someone on LinkedIn said that this model cannot code. This Elixir / Phoenix LiveView web app is the
rebuttal, because some people won't be convinced about something unless you show it to them; and even then they might shift the goalpost.

It does not matter in the end. Those who want to remain in [the cave](https://leanpub.com/cave) will not let themselves be convinced.

Qwen3.8-27B is great at coding regardless, but only if you know how to wield it, as with any other tool.

## How to use Qwen3.8-27B as a coding agent or sub-agent

### 1. Division of labor

Alaypz was developed Qwen3.8-27B as a coding agent, not as a sub-agent. No other model was involved, because I wanted to make a point.

For more complex coding missions, I often treat Qwen3.8-27B as a core component within an agentic pipeline rather than as a standalone agent that does everything by itself, end-to-end.

* **Orchestrator:** Use Qwen3.8-Flash or DeepSeek V4.1 Flash, or Nemotron-3.5-Lightning-30B-A3B or (better) Nemotron-3.5-Bolt-74B-A9B to direct workflows and manage high-level task routing, e.g. by evaluating the complexity of a task and choosing the right model for it among a selection. 
* **Heavy-lifter / problem-solver:** That is the core role of Qwen3.8-27B in this case. The orchestrator delegates complex logic, feature implementation, and unbounded subtasks to it. At `xhigh` reasoning effort, Qwen3.8-27B can resolve a lot of ambiguity by itself, so it chews through unbounded tasks competently. Whatever it might miss, will get caught by the adversarial code review. Here, you can also use Ornith-1.5-35B-A3B, if you want to go faster and have Qwen3.8-27B or a bigger model for post-implementation reviews and fixes.
* **Bounded-task sub-agents:** Some parts or tasks of a plan are not worth the "brainpower" of Qwen3.8-27B. Smaller or faster models can be used for those. The orchestrator will delegate mechanical, straightforward, or strictly-bounded tasks to models like Ornith-1.5-35B-A3B, Qwen3.6-35B-A3B, or for even simpler tasks, Groot-19B-A3B, Ornith-1.5-9B or other derivatives of Qwen3.5-9B, such as MiMo-V2.6-Distill-Qwen-9B or LAR-9B.
* **Adversarial code reviewers:** After each implementation task has completed, the orchestrator either runs and adversarial-review and bugfixing pass on the sub-agent's deliverable, or initiates an incremental run of Alibaba’s `open-code-review` configured with a model like Qwen3.8-27B and above.

The above has worked well for me for months now.

## 2. Context window and knowledge management

While hardware setups vary and with them the models you can run, and at which quantization and context window size, having agents and sub-agents document their progress and lessons learned as they go along is key in reducing the probability of rework.

* **Use lean indexes:** Instead of an ever-growing `AGENTS.md` that eats into your context, implement a dedicated knowledge/skill manager skill that keeps track of TODO items, "WONTDO" items, decisions, constraints, lessons learned, cookbooks and progress in "lean indexes" that point to granular Markdown documents loaded on demand.
* **Structured planning and review:** Have Qwen3.8-27B, the orchestrator model, or a bigger model write and adversarially review a thorough execution plan before starting. Ask the planner to design the plan _specifically_ so that discrete subtasks can be handed off safely to smaller, "dumber" subagents.

## 3. Grounding

Qwen3.8-27B excels when working within well-defined structural boundaries:

* **Step onto solid ground:** Maintain clean, refactored codebases and clearly documented design patterns (e.g., Domain-Driven Design principles). Work with the model on the architecture instead of letting it pile code on top of other code. Early work on concept, requirements, architecture and knowledge-management work pays off.
* **Guide with skills and rules:** Provide session guidance, project rules, and explicit design constraints so the model can reliably surface refactoring recommendations and follow established architectural patterns with more autonomy. Once something has been set in stone, ask it to extract a cookbook for that aspect of the system, so that sub-agents working on other plans in the future do not reinvent the wheel or stray from established conventions.
* **Give the next session or project a head-start:** Ask a model with a sufficiently large context window to review prior sessions and extract a "working-mode" skill. Do the same to extract insights from session about how well sub-agent models got their work done, and have the model write a "model-routing" skill so that orchestrator models improve their routing decisions. Do this periodically. Every session's log is a goldmine.
* **Avoid one-shot benchmarks:** Move past underspecified single prompts (like "make me `$GAME`") to evaluate models that you'll be using as sub-agents. Real-world utility comes from structured multi-step development, full feature integration, and iterative refinement over time. If you want to have a more structured approach for evaluating models as sub-agents for specific tasks and/or programming languages, work with Qwen3.8-27B or similar (or bigger) models to create one or more standard benchmarking prompts. Have an orchestrator run this "bake-off" across the models you consider as sub-agent candidates. Use this to improve the model-routing skill.

## The concept

A neon block-stacker with a deliberately tight product surface: play
your own tower, watch every other game live, keep the history. The
working approach is the whole point of this, i.e. how it was developed exclusively by Qwen3.8-27B.

The choice of game is not important, and it's not central to the software. Substitute any game with ticks, and the same thing can be done for it, by the same model. The game itself is in fact the smaller half of the product. Lobby,
leaderboard, live-spectating any user's game, replaying any game, all that is where architectural judgment gets evaluated. Phoenix
LiveView, WebSockets, PubSub, a GenServer per game, a pure engine
shared with the replays. I did not write any code by hand. I sat in the driver's seat: requirements, a plan, rounds, review. The model did the typing, the implementation of the tests, and the testing after every round.

It took a decent amount of turns. The lead-time gap between the turns in the timeline below is because I was busy with other things or sleeping, not the actual working time of the model. After the first turn when the game was playable, I started providing more guidance, sometimes sending a screenshot or a one-line complaint and indication of how I want things fixed. I do not emphasize looks early on, and I do not care about getting both the functionality _and_ the UI design/styling done in parallel.

The full test suite must pass with every `mix precommit` at the end of every turn, and must look proper using a headless-browser walk for all responsive-design breakpoints from 387 to 1440 px.

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
