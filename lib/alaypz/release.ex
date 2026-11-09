defmodule Alaypz.Release do
  @moduledoc """
  Runs database migrations without starting the server.

  The container entrypoint (deploy/entrypoint.sh) calls:

      bin/alaypz evaluate Alaypz.Release.migrate

  `bin/migrate` does not exist in the release (Mix.Release did not
  generate one for this project), and `bin/alaypz evaluate` boots the
  full app — including the repo, configured by the prod block of
  config/runtime.exs from `DATABASE_PATH` — before running the
  function. Idempotent: already-applied migrations are skipped.
  """

  @doc "Runs all pending Ecto migrations for the configured repos."
  def migrate do
    for repo <- Application.get_env(:alaypz, :ecto_repos) do
      Ecto.Migrator.run(repo, "priv/repo/migrations", :up, all: true)
    end
  end
end
