defmodule Alaypz.Scores.Score do
  use Ecto.Schema
  import Ecto.Changeset

  alias Alaypz.Players.Player

  @schema_prefix nil

  schema "scores" do
    belongs_to :player, Player
    field :score, :integer
    field :lines, :integer
    field :level, :integer
    field :end_reason, :string
    field :board, :string
    field :seed, :integer
    field :replay, :map

    timestamps(datetime: {:inserted_at, type: :naive_datetime})
  end

  @end_reasons ~w(finished interrupted)

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:player_id, :score, :lines, :level, :end_reason, :board, :seed, :replay])
    |> validate_required([:player_id, :score, :lines, :level, :end_reason, :board])
    |> validate_number(:score, greater_than_or_equal_to: 0)
    |> validate_number(:lines, greater_than_or_equal_to: 0)
    |> validate_number(:level, greater_than_or_equal_to: 1)
    |> validate_inclusion(:end_reason, @end_reasons)
    |> validate_length(:board, is: 200)
  end
end
