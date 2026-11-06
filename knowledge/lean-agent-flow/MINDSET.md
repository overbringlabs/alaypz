# MINDSET — always-loaded principles

Keep this file ≤ ~40 lines: principles only, one line each; mechanisms live in
the docs it points at. Amend when a principle is earned; prune when a pointer
serves.

## Anti-scatter
- Explore the set before committing to the point; decide at the last responsible moment; until then open questions are TODO rows, not memories.
- Communicate constraints to each other, not detailed designs (see CONSTRAINTS.md).
- Take a position: one recommendation with the trade-off visible. Trade-offs without relativism.
- One active chunk per agent; the next only when the five orthogonality tests pass in writing. Bytes are disjoint *in the moment you write*; contracts, resources and rulings are disjoint for the span.
- Questions carry their own context: state the tension, what each option does and costs — the operator must never open a file to be able to answer.

## Anti-hand-off
- Knowledge is a deliverable: it lands in the tree in the same turn as the work.
- The plan under `plans/` is amended while implementing — it is the coordination device.
- Flow is the absence of stops: the collision signal is *in flight* (a live claim in IN_FLIGHT.md, or a write in the last minutes), never merely *dirty*. A blocked step reroutes to a ready later step and circles back; only zero ready steps pauses the plan, and then it names the claim that blocks.
- Uncommitted and idle is parked work: edit on top of it and commit each verified step as it lands. Long dirty windows are the blocking you are manufacturing for everyone else.
- Custody beats ceremony: foreign live bytes are the foreigner's to commit; a vanished edit is read on disk first, never silently re-applied.
- Anything a cold start (or a weeks-later operator) must know lives in PROGRESS.md or a ledger index.
- Plain prose; the reader juggles sessions. No essays, no jargon-compression.

## Anti-wishful
- Evidence from the source (genchi genbutsu): code, data, the running system — never the report about it.
- A chunk is done when a fresh verification pass confirms it; mandatory when reasoning hinted at uncertainty.
- Found defect = stop the batch, root-cause now (jidoka); the finding becomes a lesson file.
- No cargo cult: new machinery must earn its keep against an existing pattern; stale assumptions get re-verified.
- Corrections are information (hansei): priors — yours, the operator's, the docs' — adapt without ego, the same turn.

Sources & theory: skill `lean-agent-flow` §Sources, and its `references/lppd.md`.
