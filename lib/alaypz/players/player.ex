defmodule Alaypz.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias Alaypz.Scores.Score

  @schema_prefix nil

  schema "players" do
    field :name, :string
    field :name_key, :string
    field :secret_salt, :binary
    field :secret_hash, :binary

    has_many :scores, Score

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> trim_name()
    |> validate_length(:name, max: 24)
    |> reject_whitespace()
    |> normalize_name_key()
  end

  defp trim_name(changeset) do
    case get_field(changeset, :name) do
      nil ->
        changeset

      name ->
        put_change(changeset, :name, String.trim(name))
    end
  end

  defp reject_whitespace(changeset) do
    case get_field(changeset, :name) do
      name when is_binary(name) ->
        if String.contains?(name, " ") do
          add_error(changeset, :name, "must be a single word")
        else
          changeset
        end

      _ ->
        changeset
    end
  end

  defp normalize_name_key(changeset) do
    case get_field(changeset, :name) do
      name when is_binary(name) ->
        put_change(changeset, :name_key, String.downcase(name))

      _ ->
        changeset
    end
  end
end
