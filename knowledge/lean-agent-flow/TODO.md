# TODO — generated index of pending and parked work

Built from the front-matter of each body in `todo/`, beside this index. Do not hand-edit a row:
amend the body and regenerate. A decision log, not a task board. Status per row: 🟡 awaiting a
decision (design not free to assume) · ⚪ parked with a named revisit trigger · 🔴 in progress.
A finished item leaves this index the same turn; its record goes to `PROGRESS.md`. Do not
revive a parked item without a new decision entry.

## Entries

(no entries yet)

## Row shape

| **Title** (YYYY-MM-DD, status) | areas | What decides it; the trigger that unparks it | `todo/YYYYMMDD_slug.md` |

## Body front-matter

```yaml
---
id: T-YYYYMMDD-NN
date: YYYY-MM-DD
status: open             # open | parked | in-progress
trigger: The event that unparks this
areas: [scope]
question: What is pending
---
```
