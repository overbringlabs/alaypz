defmodule Alaypz.Replay do
  @moduledoc """
  Deterministic replay of a recorded game.

  A recording is the game's `seed` plus the applied inputs, each stamped with
  the number of gravity ticks done before it landed (`Alaypz.Games.Game`
  records these while running). The engine is a pure function of its seed and
  input order, so `run/3` rebuilds the exact final engine state: the replayed
  final board equals the persisted final board.

  Inputs are stored JSON-safe (`[tick, "left"]` — strings, not atoms) and are
  validated against the known action set before use.
  """
  alias Alaypz.Game

  @actions [:left, :right, :cw, :ccw, :soft, :hard, :hold]

  @doc "Valid input actions (the replayed set). Unknown actions are ignored."
  def actions, do: @actions

  @doc """
  Replays a recording and returns the final engine state.

  `inputs` is a list of `[tick, action]` pairs — `tick` is the number of
  gravity ticks done before the input landed, `action` a string — and
  `ticks` is the total number of gravity ticks the game ran for (the replay
  clock limit; a game that top-outed early stops as soon as the engine ends).
  """
  def run(seed, ticks, inputs) do
    by_tick =
      inputs
      |> Enum.filter(fn item ->
        is_list(item) and length(item) == 2 and
          Enum.at(item, 1) in action_strings()
      end)
      |> Enum.group_by(fn [t, _a] -> t end, fn [_t, a] -> a end)

    engine = Game.new(seed)
    engine = apply_actions(engine, by_tick, 0)
    do_run(engine, by_tick, 0, ticks)
  end

  defp action_strings, do: Enum.map(@actions, &to_string/1)

  defp do_run(engine, by_tick, tick, total) do
    if Game.playing?(engine) and tick < total do
      # An input stamped with `n` landed after the n-th tick.
      engine = Game.tick(engine)
      engine = apply_actions(engine, by_tick, tick + 1)
      do_run(engine, by_tick, tick + 1, total)
    else
      engine
    end
  end

  defp apply_actions(engine, by_tick, tick) do
    for action <- Map.get(by_tick, tick, []), reduce: engine do
      acc -> Game.apply(acc, String.to_existing_atom(action))
    end
  end
end
