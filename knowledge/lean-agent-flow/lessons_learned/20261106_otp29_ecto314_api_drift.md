---
id: L-20261106-01
date: 2026-11-06
areas: [elixir, otp, ecto, testing]
touches: ["lib/**", "test/**"]
rule: Before calling an OTP or Ecto API, verify it exists in the installed version (deps/ source + function_exported?) — OTP 29 and Ecto 3.14 removed/renamed several long-standing APIs.
---

## Symptom

Repeated compile-time `undefined or private` warnings and runtime `UndefinedFunctionError` for
standard-looking APIs in this repo (Elixir 1.20.4, OTP 29.1.1, Ecto 3.14.3, via mise).

## Evidence

- `:crypto.timing_safe_match/2` does not exist (OTP 29, crypto 5.10):
  `function_exported?(:crypto, :timing_safe_match, 2)` → `false`; calling it raises
  `UndefinedFunctionError`. `:cryptohash.timing_safe_match/2` is the usual home, but the mise
  OTP install cannot load the `:cryptohash` app (`could not find application file: cryptohash.app`).
  Resolution used: pure-Elixir constant-time compare (`:binary.bin_to_list` + `Bitwise.bxor` sum)
  over SHA-256 digests — `:crypto.hash/2` and `:crypto.strong_rand_bytes/1` are available.
- `:binary.splattolist/1` removed in this OTP → use `:binary.bin_to_list/1`.
- Ecto 3.14: `validate_unique`/`validate_unique_excluding` no longer exist
  (`grep "def validate_unique" deps/ecto/lib` → no matches). Enforce uniqueness at the context
  (query before insert) and keep the DB unique index as the race backstop.
- Ecto 3.14 `validate_number/3`: `>=:`/`<=:` shorthand options are gone; options are now
  `:greater_than_or_equal_to`, `:less_than`, etc.
- Ecto 3.14 changeset errors store `{msg, opts}` tuples: assert
  `[name: {"message", _}] = cs.errors`, not `[name: "message"]`.
- `Mix` does not accept `--no-hall`-style iex flags: `iex -S mix -e '…'` mangles multiline
  `-e` args; use `mix run --no-start /tmp/probe.exs` for scratch probes.

## Rule

Probe `function_exported?/3` and grep `deps/` before writing calls into OTP/Ecto APIs; when a
timing-safe primitive is unavailable, a short pure-Elixir XOR-sum compare is the safe fallback.
