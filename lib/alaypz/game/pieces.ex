defmodule Alaypz.Game.Pieces do
  @moduledoc """
  SRS piece data: spawn orientations and wall kick tables.

  Cell coordinates are `{col, row}` with col 0 = left and row 0 = top, inside a
  4×4 box (col/row 0..3). Rotation states: 0 (spawn), 1 (R), 2, 3 (L).
  Kick tables use the same convention with `dy` positive = down (the
  community SRS tables are y-up; signs are flipped accordingly).
  """

  @ids [:i, :j, :l, :o, :s, :t, :z]

  @spawn %{
    i: [{0, 1}, {1, 1}, {2, 1}, {3, 1}],
    j: [{0, 0}, {0, 1}, {1, 1}, {2, 1}],
    l: [{2, 0}, {0, 1}, {1, 1}, {2, 1}],
    o: [{1, 0}, {2, 0}, {1, 1}, {2, 1}],
    s: [{1, 0}, {2, 0}, {0, 1}, {1, 1}],
    t: [{1, 0}, {0, 1}, {1, 1}, {2, 1}],
    z: [{0, 0}, {1, 0}, {1, 1}, {2, 1}]
  }

  # Community SRS "J, L, S, T, Z" table, y flipped to down-positive.
  @jlstz_kicks %{
    {0, 1} => [{0, 0}, {-1, 0}, {-1, -1}, {0, 2}, {-1, 2}],
    {1, 0} => [{0, 0}, {1, 0}, {1, 1}, {0, -2}, {1, -2}],
    {1, 2} => [{0, 0}, {1, 0}, {1, 1}, {0, -2}, {1, -2}],
    {2, 1} => [{0, 0}, {-1, 0}, {-1, -1}, {0, 2}, {-1, 2}],
    {2, 3} => [{0, 0}, {1, 0}, {1, -1}, {0, 2}, {1, 2}],
    {3, 2} => [{0, 0}, {-1, 0}, {-1, 1}, {0, -2}, {-1, -2}],
    {3, 0} => [{0, 0}, {-1, 0}, {-1, 1}, {0, -2}, {-1, -2}],
    {0, 3} => [{0, 0}, {1, 0}, {1, -1}, {0, 2}, {1, 2}]
  }

  # Community SRS "I" table, y flipped to down-positive.
  @i_kicks %{
    {0, 1} => [{0, 0}, {-2, 0}, {1, 0}, {-2, 1}, {1, -2}],
    {1, 0} => [{0, 0}, {2, 0}, {-1, 0}, {2, -1}, {-1, 2}],
    {1, 2} => [{0, 0}, {-1, 0}, {2, 0}, {-1, -2}, {2, 1}],
    {2, 1} => [{0, 0}, {1, 0}, {-2, 0}, {1, 2}, {-2, -1}],
    {2, 3} => [{0, 0}, {2, 0}, {-1, 0}, {2, -1}, {-1, 2}],
    {3, 2} => [{0, 0}, {-2, 0}, {1, 0}, {-2, 1}, {1, -2}],
    {3, 0} => [{0, 0}, {1, 0}, {-2, 0}, {1, 2}, {-2, -1}],
    {0, 3} => [{0, 0}, {-1, 0}, {2, 0}, {-1, -2}, {2, 1}]
  }

  @doc "The seven tetromino ids."
  def ids, do: @ids

  @doc "The four cells of `id` in rotation state 0..3 (4×4 box, y down)."
  # SRS is a pure rotation about a single center: the middle cell's center for
  # J/L/S/T/Z (cell (1,1) -> (x, y) -> {2 - y, x}) and a gridline
  # intersection for I and O ((1.5, 1.5) -> {3 - y, x}). O never changes.
  def cells(id, 0), do: @spawn[id]
  def cells(:o, _state), do: @spawn[:o]

  def cells(:i, state) do
    Enum.reduce(1..state, @spawn[:i], fn _, cs ->
      Enum.map(cs, fn {x, y} -> {3 - y, x} end)
    end)
  end

  def cells(id, state) do
    Enum.reduce(1..state, @spawn[id], fn _, cs ->
      Enum.map(cs, fn {x, y} -> {2 - y, x} end)
    end)
  end

  @doc """
  The five kick tests for a rotation, in test order. `:o` never kicks.
  """
  def kicks(:o, _from, _to), do: [{0, 0}]
  def kicks(:i, from, to), do: @i_kicks[{from, to}]
  def kicks(_id, from, to), do: @jlstz_kicks[{from, to}]
end
