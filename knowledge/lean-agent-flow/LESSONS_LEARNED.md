# LESSONS_LEARNED — generated index of re-diagnosis preventers

Built from the front-matter of each body in `lessons_learned/`, beside this index. Do not
hand-edit a row: amend the body and regenerate. One lesson per body: symptom, cause, rule next
time. **The row is the rule, not the story** — the body carries the evidence.

## Entries

| **OTP/Ecto API drift** (2026-11-06) | elixir, otp, ecto, testing | Verify OTP/Ecto APIs against the installed version before calling — OTP 29 + Ecto 3.14 removed `:crypto.timing_safe_match`, `:binary.splattolist`, `validate_unique`, `>=:` options. | `lessons_learned/20261106_otp29_ecto314_api_drift.md` |
| **DynamicSupervisor restart default** (2026-11-06) | elixir, otp, supervision, testing | Pass `restart: :temporary` in dynamic child specs for explicitly-stopped workers — the default `:permanent` restarts them on every stop (ghosts) and rapid cycles shut the supervisor down. | `lessons_learned/20261106_dynamicsupervisor_restart_default.md` |

## Row shape

| **Title** (YYYY-MM-DD) | areas | Rule: the guard, in one sentence. | `lessons_learned/YYYYMMDD_slug.md` |

## Body front-matter

```yaml
---
id: L-YYYYMMDD-NN
date: YYYY-MM-DD
areas: [liveview, testing]
touches: ["lib/**", "test/**"]
rule: The guard, in one sentence, in the imperative.
---
```
