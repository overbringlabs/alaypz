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
    from(s in Score, where: s.player_id == ^player.id, order_by: [desc: s.score])
    |> Repo.all()
  end

  @doc "The most recently finished or interrupted games, newest first."
  def list_recent(limit \\ 5) do
    from(s in Score, order_by: [desc: s.inserted_at, desc: s.id], limit: ^limit, preload: :player)
    |> Repo.all()
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

  @doc "Decodes a 200-char board string back into a 20×10 board."
  def decode_board(str) when is_binary(str) do
    str
    |> String.graphemes()
    |> Enum.chunk_every(10)
    |> Enum.map(fn row ->
      Enum.map(row, fn
        "." -> nil
        letter -> String.to_existing_atom(letter)
      end)
    end)
  end
end
