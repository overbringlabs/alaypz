defmodule AlaypzWeb.Board do
  @moduledoc """
  Text rendering of a 20×10 board for `<pre>` grids: one char per cell
  (empty = `·`, otherwise the piece id), rows joined with newlines.
  The focused game's grid moves to the `.AlaypzCanvas` hook in step 6;
  the history views keep this text rendering.
  """

  def text(nil), do: ""

  def text(board) when is_list(board) do
    board
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn
        nil -> "·"
        id -> Atom.to_string(id)
      end)
      |> Enum.join()
    end)
    |> Enum.join("\n")
  end
end
