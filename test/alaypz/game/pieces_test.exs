defmodule Alaypz.Game.PiecesTest do
  use ExUnit.Case, async: true

  alias Alaypz.Game.Pieces

  test "all 28 piece states have exactly four distinct cells" do
    for id <- Pieces.ids(), st <- 0..3 do
      cells = Pieces.cells(id, st)
      assert length(cells) == 4, "#{id} state #{st}"
      assert length(Enum.uniq(cells)) == 4, "#{id} state #{st}"
    end
  end

  test "O never changes orientation" do
    for st <- 0..3, do: assert(Pieces.cells(:o, st) == Pieces.cells(:o, 0))
  end

  test "known SRS orientations" do
    assert Enum.sort(Pieces.cells(:t, 1)) == Enum.sort([{1, 0}, {1, 1}, {1, 2}, {2, 1}])
    assert Enum.sort(Pieces.cells(:t, 2)) == Enum.sort([{0, 1}, {1, 1}, {1, 2}, {2, 1}])
    assert Enum.sort(Pieces.cells(:i, 1)) == Enum.sort([{2, 0}, {2, 1}, {2, 2}, {2, 3}])
    assert Enum.sort(Pieces.cells(:i, 2)) == Enum.sort([{0, 2}, {1, 2}, {2, 2}, {3, 2}])
    assert Enum.sort(Pieces.cells(:i, 3)) == Enum.sort([{1, 0}, {1, 1}, {1, 2}, {1, 3}])
    assert Enum.sort(Pieces.cells(:s, 1)) == Enum.sort([{1, 0}, {1, 1}, {2, 1}, {2, 2}])
  end

  test "O never kicks" do
    for st <- 0..3, do: assert(Pieces.kicks(:o, st, rem(st + 1, 4)) == [{0, 0}])
  end

  test "kick tables are five tests starting at the origin and reversible" do
    for id <- [:i, :t, :j, :l, :s, :z], st <- 0..3 do
      to = rem(st + 1, 4)
      fwd = Pieces.kicks(id, st, to)
      bwd = Pieces.kicks(id, to, st)

      assert length(fwd) == 5, "#{id} #{st} -> #{to}"
      assert hd(fwd) == {0, 0}, "#{id} #{st} -> #{to}"

      assert fwd == Enum.map(bwd, fn {dx, dy} -> {-dx, -dy} end),
             "#{id} #{st} -> #{to} is not the sign-flip of #{to} -> #{st}"
    end
  end
end
