defmodule Alaypz.Game do
  @moduledoc """
  Pure Alaypz engine: one struct, no side effects.

  `Alaypz.Games` (plan step 3) wraps this in a GenServer; every client renders
  the state via `payload/1`, and inputs map onto `move/2`, `rotate/2`,
  `soft_drop/1`, `hard_drop/1`, `hold/1` and `tick/1`.

  Board: 20 rows × 10 cols, row 0 = top, each cell `nil` or a piece id.
  Pieces sit in a 4×4 box at `pos` (col, row); one hidden row above the
  board (row -1) is allowed during rotation and discarded on lock.
  """

  alias Alaypz.Game.Pieces
  import Bitwise

  @rows 20
  @cols 10
  @spawn_pos {3, 0}
  @clear_scores %{1 => 100, 2 => 300, 3 => 500, 4 => 800}

  defstruct board: nil,
            current: nil,
            current_state: 0,
            pos: nil,
            score: 0,
            lines: 0,
            level: 1,
            hold: nil,
            hold_used: false,
            queue: [],
            seq: 0,
            status: :playing

  @type t :: %__MODULE__{}

  # --- lifecycle -------------------------------------------------------

  @doc "Start a game with a deterministic piece queue for `seed`."
  def new(seed) do
    seq = seed &&& 0xFFFFFFFF
    {b1, seq1} = bag(seq)
    {b2, seq2} = bag(seq1)

    %__MODULE__{board: empty_board(), queue: b1 ++ b2, seq: seq2}
    |> next_piece()
  end

  @doc "Gravity step: fall one row, or lock the piece when it cannot fall."
  def tick(%{status: :playing, pos: {x, y}} = s) do
    if valid?(s, x, y + 1) do
      %{s | pos: {x, y + 1}}
    else
      lock(s)
    end
  end

  def tick(%{} = s), do: s

  # --- player inputs (no-ops when invalid) -----------------------------

  def move(%{status: :playing} = s, :left), do: shift(s, -1, 0)
  def move(%{status: :playing} = s, :right), do: shift(s, 1, 0)
  def move(%{} = s, _dir), do: s

  def soft_drop(%{status: :playing, pos: {x, y}} = s) do
    if valid?(s, x, y + 1) do
      %{s | pos: {x, y + 1}, score: s.score + 1}
    else
      s
    end
  end

  def soft_drop(%{} = s), do: s

  @doc "Drop to the ghost position (+2 per cell) and lock immediately."
  def hard_drop(%{status: :playing, pos: {_x, y}} = s) do
    {gx, gy} = ghost_pos(s)
    s = %{s | pos: {gx, gy}, score: s.score + 2 * (gy - y)}
    lock(s)
  end

  def hard_drop(%{} = s), do: s

  def rotate(%{status: :playing} = s, :cw), do: do_rotate(s, 1)
  def rotate(%{status: :playing} = s, :ccw), do: do_rotate(s, 3)
  def rotate(%{} = s, _dir), do: s

  @doc """
  Swap in the held piece. Rejected while `hold_used`; a locked piece resets
  the flag. When the spawn position is blocked the game tops out.
  """
  def hold(%{status: :playing, hold_used: true} = s), do: s

  def hold(%{status: :playing, current: id, hold: held, seq: seq} = s) do
    {next_id, queue, seq} =
      if held == nil do
        pop(s.queue, seq)
      else
        {held, s.queue, seq}
      end

    base = %{
      s
      | current: next_id,
        current_state: 0,
        hold: id,
        hold_used: true,
        pos: @spawn_pos,
        queue: queue,
        seq: seq
    }

    if valid?(base, elem(@spawn_pos, 0), elem(@spawn_pos, 1)) do
      base
    else
      %{base | status: :topped_out, current: nil}
    end
  end

  def hold(%{} = s), do: s

  # --- queries ----------------------------------------------------------

  @doc "Lowest position the current piece fits at (ghost piece)."
  def ghost_pos(%{pos: {x, y}} = s) do
    Enum.reduce(0..19, {x, y}, fn dy, acc ->
      if valid?(s, x, y + dy), do: {x, y + dy}, else: acc
    end)
  end

  @doc "Guideline fall interval in ms for `level` (clamped to a 100 ms floor)."
  def falling_interval_ms(level) do
    ms = :math.pow(0.8 - (level - 1) * 0.007, level - 1) * 1000
    max(100, round(ms))
  end

  @doc "True while the game accepts input."
  def playing?(%{status: :playing}), do: true
  def playing?(%{}), do: false

  @doc "Wire-ready state for the client (everything a renderer needs)."
  def payload(s) do
    %{
      board: s.board,
      piece: if(s.current, do: %{id: s.current, state: s.current_state, pos: s.pos}),
      score: s.score,
      lines: s.lines,
      level: s.level,
      hold: s.hold,
      queue: Enum.take(s.queue, 3),
      status: s.status
    }
  end

  # --- internals ---------------------------------------------------------

  defp shift(%{pos: {x, y}} = s, dx, dy) do
    if valid?(s, x + dx, y + dy) do
      %{s | pos: {x + dx, y + dy}}
    else
      s
    end
  end

  defp do_rotate(%{current: id, current_state: st, pos: {x, y}} = s, delta) do
    next_st = rem(st + delta, 4)

    rotated = %{s | current_state: next_st}

    case Enum.reduce_while(Pieces.kicks(id, st, next_st), nil, fn {dx, dy}, _acc ->
           nx = x + dx
           ny = y + dy

           if valid?(rotated, nx, ny) do
             {:halt, %{s | current_state: next_st, pos: {nx, ny}}}
           else
             {:cont, nil}
           end
         end) do
      nil -> s
      rotated -> rotated
    end
  end

  defp lock(%{current: id, current_state: st, pos: {x, y}} = s) do
    cells = Pieces.cells(id, st)
    board = merge(s.board, cells, x, y, id)
    {n, board} = clear_rows(board)
    lines = s.lines + n
    score = s.score + Map.get(@clear_scores, n, 0) * s.level

    base = %{
      s
      | board: board,
        lines: lines,
        score: score,
        level: div(lines, 10) + 1,
        hold_used: false
    }

    {next_id, queue, seq} = pop(base.queue, base.seq)

    candidate = %{
      base
      | current: next_id,
        current_state: 0,
        pos: @spawn_pos,
        queue: queue,
        seq: seq
    }

    if valid?(candidate, elem(@spawn_pos, 0), elem(@spawn_pos, 1)) do
      candidate
    else
      # Keep the board and stats: the finished board must stay observable.
      %{s | status: :topped_out, current: nil}
    end
  end

  defp next_piece(s) do
    {id, q, seq} = pop(s.queue, s.seq)
    %{s | current: id, current_state: 0, pos: @spawn_pos, queue: q, seq: seq}
  end

  # Take the front piece; refill with a fresh 7-bag when fewer than 7 remain,
  # threading the LCG state forward so each bag differs.
  defp pop(queue, seq) do
    [id | rest] = queue

    {rest, seq} =
      if length(rest) < 7 do
        {bag, seq} = bag(seq)
        {rest ++ bag, seq}
      else
        {rest, seq}
      end

    {id, rest, seq}
  end

  # Deterministic 7-bag: Fisher–Yates over the seven ids with a 32-bit LCG,
  # so a given seed always produces the same game.
  defp bag(seq) do
    {shuffled, seq} =
      Enum.reduce(7..1//-1, {Pieces.ids(), seq}, fn i, {list, s} ->
        s = s * 6_364_136_223 + 1 &&& 0xFFFFFFFF
        j = rem(s, i)
        a = Enum.at(list, i - 1)
        b = Enum.at(list, j)
        {List.replace_at(List.replace_at(list, i - 1, b), j, a), s}
      end)

    {shuffled, seq}
  end

  defp valid?(%{board: board, current: id, current_state: st}, x, y) do
    Enum.all?(Pieces.cells(id, st), fn {cx, cy} ->
      bx = x + cx
      by = y + cy

      bx >= 0 and bx < @cols and by >= -1 and by < @rows and
        (by < 0 or Enum.at(Enum.at(board, by), bx) == nil)
    end)
  end

  defp merge(board, cells, x, y, id) do
    cells
    |> Enum.reject(fn {_, cy} -> y + cy < 0 end)
    |> Enum.reduce(board, fn {cx, cy}, b ->
      row = List.replace_at(Enum.at(b, y + cy), x + cx, id)
      List.replace_at(b, y + cy, row)
    end)
  end

  defp clear_rows(board) do
    {full, rest} = Enum.split_with(board, &full?/1)
    {length(full), List.duplicate(List.duplicate(nil, @cols), length(full)) ++ rest}
  end

  defp full?(row), do: Enum.all?(row, &(&1 != nil))

  defp empty_board(), do: List.duplicate(List.duplicate(nil, @cols), @rows)
end
