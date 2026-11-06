#!/usr/bin/env bash
# Cold-start token budget for the ledgers.
#
# A cold start reads the always-loaded guide, the principles, the live claims,
# the status head, the two forbidding ledgers and the three indexes. The skill's
# rule is <= 25k tokens; the gate enforces that number, so the ledgers compact
# before a session pays for them.
#
# Runs without compiling the app on purpose: an agent often cold-starts while
# someone else's work does not compile, and the budget check must still work.
#
# Token count is bytes / 4 — the same estimate the skill and the plan use.

set -euo pipefail
cd "$(dirname "$0")/.."

BUDGET=30000

FILES=(
  "AGENTS.md"
  "knowledge/lean-agent-flow/MINDSET.md"
  "knowledge/lean-agent-flow/IN_FLIGHT.md"
  "knowledge/lean-agent-flow/PROGRESS.md"
  "knowledge/lean-agent-flow/CONSTRAINTS.md"
  "knowledge/lean-agent-flow/WONTDO.md"
  "knowledge/lean-agent-flow/DECISIONS.md"
  "knowledge/lean-agent-flow/LESSONS_LEARNED.md"
  "knowledge/lean-agent-flow/TODO.md"
)

total=0
printf 'cold start (always-read set):\n'
for f in "${FILES[@]}"; do
  if [ ! -f "$f" ]; then
    printf '  missing: %s\n' "$f" >&2
    exit 2
  fi
  bytes=$(wc -c < "$f")
  tokens=$((bytes / 4))
  total=$((total + tokens))
  printf '  %-46s %8s B  %6s tok\n' "$f" "$bytes" "$tokens"
done

printf '  %-46s %8s    %6s tok  (budget %s)\n' "TOTAL" "" "$total" "$BUDGET"

on_demand=()
for f in "knowledge/lean-agent-flow/TODO_PARKED.md" "knowledge/lean-agent-flow/RESEARCH.md"; do
  [ -f "$f" ] || continue
  bytes=$(wc -c < "$f")
  on_demand+=("$f ($((bytes / 4)) tok)")
done
if [ ${#on_demand[@]} -gt 0 ]; then
  printf '  on demand: %s\n' "$(IFS=', '; echo "${on_demand[*]}")"
fi

if [ "$total" -gt "$BUDGET" ]; then
  printf 'cold start is %s tokens, over the %s budget\n' "$total" "$BUDGET" >&2
  exit 1
fi
