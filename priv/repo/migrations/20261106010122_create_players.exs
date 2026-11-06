defmodule Alaypz.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string, null: false
      add :name_key, :string, null: false
      add :secret_salt, :binary, null: false
      add :secret_hash, :binary, null: false
      timestamps()
    end

    create unique_index(:players, :name_key)
  end
end
