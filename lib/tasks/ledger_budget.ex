defmodule Mix.Tasks.Ledger.Budget do
  @shortdoc "Check the knowledge ledger cold-start token budget (scripts/ledger_budget.sh)."

  @moduledoc """
  Runs `scripts/ledger_budget.sh` without starting the app: the budget check
  must keep working while someone else's work does not compile.
  """
  use Mix.Task

  def run(_args) do
    script = Path.join("scripts", "ledger_budget.sh")

    unless File.exists?(script) do
      Mix.raise("ledger budget: missing #{script}")
    end

    {output, status} = System.cmd("bash", [script], stderr_to_stdout: true)
    IO.puts(output)
    if status != 0, do: Mix.raise("ledger budget gate failed (exit #{status})")
  end
end
