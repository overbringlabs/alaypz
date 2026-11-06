---
id: L-20261106-02
date: 2026-11-06
areas: [elixir, otp, supervision, testing]
touches: ["lib/alaypz/games.ex", "lib/alaypz/games/**"]
rule: A `DynamicSupervisor.start_child` map without an explicit `restart:` defaults to `restart: :permanent` — which restarts the child on *every* termination, including explicit `GenServer.stop`. Set `restart: :temporary` for explicitly-started, explicitly-stopped workers, or stopped "ghosts" re-take their resources and rapid stop/start cycles trip the supervisor's restart intensity, shutting the whole supervisor (and every sibling) down.
---

# DynamicSupervisor dynamic children default to `restart: :permanent`

## Symptom

Stops of a dynamically-started GenServer "didn't take": the process died
(`:normal`), yet the name it registered came back moments later, owned by a
fresh process with a new pid. Under rapid stop/start, the supervisor itself
died, and in-flight `start_child` callers exited with
`{:shutdown, {GenServer, :call, [supervisor, {:start_child, _}, _]}}`.

## Cause

`Supervisor.child_spec/2` fills a missing `:restart` with `:permanent` — and
for `DynamicSupervisor` the `:permanent` clause in
`maybe_restart_child/5` is ordered *before* the `:normal`-termination clause,
so even a clean `GenServer.stop`-driven `:normal` exit counts as a
restart-and-report. Two compounding effects:

1. The restarted copy re-ran `init` and re-took the process's registry name —
   a "ghost" game answering for a player whose game was stopped.
2. Each stop+restart consumed one of the supervisor's 3 restarts per 5 s; the
   4th tripped `reached_max_restart_intensity` → `{:stop, :shutdown, state}`
   → the supervisor terminated → pending `start_child` calls exited.

## Rule

For processes that are started and stopped by application code (not by the
supervisor's own restart policy), pass `restart: :temporary` in the dynamic
child spec. Reserve `:permanent`/`:transient` for children whose liveness the
supervisor must own.

## Related traps found the same session

- `%{map | key: value}` and `map[:key]` both **raise** when the key is absent
  on a plain map (struct update is the safe form). Initialize every state key
  in `init`; read with `Map.get`.
- `Registry` entries linger until the registry processes the process's DOWN;
  a re-register retry loop must sleep, and must **not** stop the registered
  pid without verifying it is still the same logical process (pids are
  reused).
- `GenServer.stop` on a process that traps exit is swallowed as a message;
  if you don't handle `{:EXIT, _, _}`, the process never dies.
