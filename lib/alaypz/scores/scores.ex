defmodule Alaypz.Scores do
  @moduledoc """
  Persisted game outcomes: one row per finished or interrupted game
  (D-20261106-02). `board` is the final 20×10 grid as a 200-char string
  (one char per cell, `.` empty) so `/leaderboard` can draw it.
  """

  import Ecto.Query
  alias Alaypz.Repo
  alias Alaypz.Scores.Score

  def list_top(limit \\ 10) do
    from(s in Score,
      order_by: [desc: s.score, desc: s.inserted_at],
      limit: ^limit,
      preload: :player
    )
    |> Repo.all()
  end

  def list_for_player(player) do
    from(s in Score,
      where: s.player_id == ^player.id,
      order_by: [desc: s.score],
      preload: :player
    )
    |> Repo.all()
  end

  @doc "A single game result by id, with its player. `nil` when unknown."
  def get(id) do
    from(s in Score, where: s.id == ^id, preload: :player) |> Repo.one()
  end

  def record(attrs) do
    %Score{}
    |> Score.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Encodes a 20×10 board (nil or piece id per cell) into a 200-char string."
  def encode_board(board) when is_list(board) do
    board
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn
        nil -> "."
        id -> Atom.to_string(id)
      end)
      |> Enum.join()
    end)
    |> Enum.join()
  end

  # Board cells are single piece ids; the lookup map keeps decoding free of
  # dynamic atom creation (stored data must never mint atoms).
  @piece_chars %{
    "i" => :i,
    "j" => :j,
    "l" => :l,
    "o" => :o,
    "s" => :s,
    "t" => :t,
    "z" => :z
  }

  @doc "Decodes a 200-char board string back into a 20×10 board."
  def decode_board(str) when is_binary(str) do
    str
    |> String.graphemes()
    |> Enum.chunk_every(10)
    |> Enum.map(fn row ->
      Enum.map(row, fn
        "." -> nil
        letter -> Map.get(@piece_chars, letter)
      end)
    end)
  end
end
