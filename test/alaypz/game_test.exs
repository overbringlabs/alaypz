defmodule Alaypz.GameTest do
  use ExUnit.Case, async: true

  alias Alaypz.Game
  alias Alaypz.Game.Pieces

  @ids Pieces.ids()

  defp empty(), do: List.duplicate(List.duplicate(nil, 10), 20)

  defp game(opts \\ %{}) do
    %{
      board: empty(),
      current: :t,
      current_state: 0,
      pos: {3, 0},
      score: 0,
      lines: 0,
      level: 1,
      hold: nil,
      hold_used: false,
      queue: @ids ++ @ids,
      seq: 7,
      status: :playing
    }
    |> Map.merge(Map.new(opts))
  end

  # --- lifecycle ----------------------------------------------------------

  test "new/1 starts a playing game with a full queue" do
    s = Game.new(42)
    assert s.status == :playing
    assert s.current
    assert s.pos == {3, 0}
    assert s.score == 0
    assert s.level == 1
    assert length(s.queue) == 13
    assert empty_board?(s.board)
  end

  defp empty_board?(board), do: Enum.all?(board, fn row -> Enum.all?(row, &(&1 == nil)) end)

  test "the queue is a deterministic sequence of 7-bags" do
    assert Game.new(42).queue == Game.new(42).queue
    assert Game.new(1).queue != Game.new(2).queue

    s = Game.new(1)
    # The first bag is the consumed piece plus the six queue entries that
    # follow it; the last seven entries are the second, untouched bag.
    first_bag = [s.current | Enum.take(s.queue, 6)]
    second_bag = Enum.take(s.queue, -7)
    assert Enum.sort(first_bag) == Enum.sort(@ids)
    assert Enum.sort(second_bag) == Enum.sort(@ids)
  end

  test "hard drop consumes the queue without premature refill" do
    s = Game.new(1)
    assert length(Game.hard_drop(s).queue) == 12
  end

  # --- movement -----------------------------------------------------------

  test "movement respects walls" do
    s = game()
    assert Game.move(s, :left).pos == {2, 0}
    assert Enum.reduce(1..10, s, fn _i, acc -> Game.move(acc, :left) end).pos == {0, 0}
    assert Enum.reduce(1..10, s, fn _i, acc -> Game.move(acc, :right) end).pos == {7, 0}
  end

  test "soft drop falls one row, scores, and stops at the floor" do
    s = game()
    assert Game.soft_drop(s).pos == {3, 1}
    assert Game.soft_drop(s).score == 1

    at_floor = Enum.reduce(1..18, s, fn _i, acc -> Game.soft_drop(acc) end)
    assert at_floor.pos == {3, 18}
    assert at_floor.score == 18
    assert Game.soft_drop(at_floor) == at_floor
  end

  test "ghost position is the lowest fitting row" do
    assert Game.ghost_pos(game()) == {3, 18}
    assert Game.ghost_pos(game(current: :o)) == {3, 18}
    assert Game.ghost_pos(game(current: :i)) == {3, 18}
  end

  # --- rotation -----------------------------------------------------------

  test "rotation on an open board needs no kick" do
    s = game()
    r = Game.rotate(s, :cw)
    assert r.current_state == 1
    assert r.pos == {3, 0}
    assert Game.rotate(r, :ccw).current_state == 0
  end

  test "SRS floor kick for T at the bottom" do
    r = Game.rotate(game(pos: {3, 18}), :cw)
    assert r.current_state == 1
    assert r.pos == {2, 17}
  end

  # --- locking, clearing, scoring ------------------------------------------

  test "hard drop lands on the floor, scores, and spawns the next piece" do
    d = Game.hard_drop(game())
    assert d.current == :i
    assert d.pos == {3, 0}
    assert d.score == 36
    assert d.hold_used == false
    assert [nil, nil, :t] == for(r <- 17..19, do: Enum.at(Enum.at(d.board, r), 3))
    assert Enum.at(Enum.at(d.board, 18), 4) == :t
    assert Enum.at(Enum.at(d.board, 19), 5) == :t
  end

  test "single line clear scores 100 x level" do
    bottom = List.duplicate(:z, 2) ++ List.duplicate(nil, 2) ++ List.duplicate(:z, 6)
    s = game(board: List.replace_at(empty(), 19, bottom), current: :o, pos: {1, 17})
    s = Game.tick(s)
    assert s.pos == {1, 18}
    s = Game.tick(s)
    assert s.score == 100
    assert s.lines == 1
    assert s.level == 1
    # The cleared row shifts: the O's top half (row 18) drops into row 19.
    assert Enum.at(s.board, 19) == [nil, nil, :o, :o, nil, nil, nil, nil, nil, nil]
    assert Enum.all?(Enum.at(s.board, 18), &(&1 == nil))
    assert s.current == :i
  end

  test "alaypz clears four lines for 800 x level" do
    gap = fn -> List.duplicate(:z, 3) ++ [nil] ++ List.duplicate(:z, 6) end

    board =
      empty()
      |> List.replace_at(16, gap.())
      |> List.replace_at(17, gap.())
      |> List.replace_at(18, gap.())
      |> List.replace_at(19, gap.())

    s = Game.hard_drop(game(board: board, current: :i, current_state: 1, pos: {1, 12}))
    assert s.lines == 4
    # 800 for the alaypz + 8 for the four-cell hard drop (2 points per cell).
    assert s.score == 808
    assert s.level == 1
  end

  test "level rises every ten lines and scoring uses the pre-clear level" do
    bottom = List.duplicate(:z, 2) ++ List.duplicate(nil, 2) ++ List.duplicate(:z, 6)

    s =
      game(
        board: List.replace_at(empty(), 19, bottom),
        current: :o,
        pos: {1, 17},
        lines: 19,
        level: 2
      )

    s = Game.tick(s) |> Game.tick()
    assert s.lines == 20
    assert s.level == 3
    assert s.score == 200
  end

  test "falling interval follows the guideline curve" do
    assert Game.falling_interval_ms(1) == 1000
    assert Game.falling_interval_ms(2) == 793
    assert Game.falling_interval_ms(15) == 100

    assert Enum.all?(1..20, fn lvl ->
             Game.falling_interval_ms(lvl) >= Game.falling_interval_ms(lvl + 1)
           end)
  end

  # --- hold ----------------------------------------------------------------

  test "hold swaps pieces and re-arms after the next lock" do
    s = game()
    h = Game.hold(s)
    assert h.hold == :t
    assert h.current == :i
    assert h.hold_used
    assert Game.hold(h) == h

    dropped = Game.hard_drop(h)
    assert dropped.hold_used == false

    # The locked piece was :i; the piece on the board when the swap happens
    # is :j, so hold takes :j back into the slot.
    h2 = Game.hold(dropped)
    assert h2.current == :t
    assert h2.hold == :j
    assert h2.hold_used
  end

  # --- game over -------------------------------------------------------------

  test "a blocked spawn tops the game out" do
    wall = [nil, nil, nil, :z, :z, :z, :z, nil, nil, nil]

    board =
      empty()
      |> List.replace_at(0, wall)
      |> List.replace_at(1, wall)

    t = Game.hold(game(board: board, current: :t, hold: :j))
    assert t.status == :topped_out
    assert t.current == nil
    assert Game.tick(t) == t
    assert Game.hold(t) == t
  end

  # --- payload ----------------------------------------------------------------

  test "payload exposes the renderer's state" do
    p = Game.payload(game())
    assert p.piece == %{id: :t, state: 0, pos: {3, 0}}
    assert p.score == 0
    assert p.queue == Enum.take(@ids, 3)
    assert p.status == :playing

    blocked = empty() |> List.replace_at(0, List.duplicate(:z, 10))
    t = Game.hold(game(board: blocked, current: :t, hold: :j))
    assert t.status == :topped_out
    assert Game.payload(t).piece == nil
  end
end
