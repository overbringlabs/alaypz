defmodule Alaypz.Repo.Migrations.AddReplayToScores do
  use Ecto.Migration

  def change do
    alter table(:scores) do
      add :seed, :integer
      add :replay, :map
    end
  end
end
