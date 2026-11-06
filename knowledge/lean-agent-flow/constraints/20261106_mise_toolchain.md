---
id: C-20261106-04
date: 2026-11-06
status: standing
areas: [tooling]
rule: Elixir work goes through mise only — elixir 1.20.4-otp-29 / erlang 29.1.1; agent shells run mix via `mise exec --`.
---
# Elixir toolchain via mise

From `mise.toml` (project) + elixir-mise skill: agent shells are
non-interactive, `~/.bashrc` returns before mise activation, and half-activated
PATHs pair a mise Elixir with a system `erl`.

- Verify once per session: `mise current` (expect elixir 1.20.4-otp-29,
  erlang 29.1.1) and `mise exec -- bash -c 'command -v erl; elixir --version'`.
- Prefix every Elixir command: `mise exec -- mix …`.
- `mix precommit` is the commit gate (compile with warnings-as-errors,
  `deps.unlock --unused`, format, test, ledger budget).
