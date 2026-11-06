# DECISIONS — generated index of rulings with reasons

Built from the front-matter of each body in `decisions/`, beside this index. Do not hand-edit a
row: amend the body and regenerate. One line per ruling, ≤ ~160 chars: title, date, status,
areas, the ruling in one sentence, path. Never delete a superseded entry — its status says
`superseded-by:D-…` and points at the replacement.

## Entries

| **Alaypz scope (S1–S8)** (2026-11-06, standing) | scope, design | Eight scope questions confirmed by operator: rules, loop, spectator sync, rendering, persistence, lifecycle, input, tests. | `decisions/20261106_alaypz_scope.md` |
| **Persistence, leaderboard & player views; unique names** (2026-11-06, standing) | persistence, naming | Final state saved on end/interrupt; top-10 `/leaderboard`; `/:player_name`; unique names, one-time access-string reclaim. | `decisions/20261106_persistence_and_views.md` |

## Row shape

| **Title** (YYYY-MM-DD, standing) | areas | The ruling, one sentence. | `decisions/YYYYMMDD_slug.md` |

## Body front-matter

```yaml
---
id: D-YYYYMMDD-NN
date: YYYY-MM-DD
status: standing        # or superseded-by:D-YYYYMMDD-NN
areas: [scope, design]
question: What this ruling decides
---
```
