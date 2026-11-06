defmodule Alaypz.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :player_id, references(:players), null: false
      add :score, :integer, null: false
      add :lines, :integer, null: false
      add :level, :integer, null: false
      add :end_reason, :string, null: false
      add :board, :string, null: false
      timestamps(datetime: {:inserted_at, type: :naive_datetime})
    end

    create index(:scores, :player_id)
    create index(:scores, :score)
  end
end
