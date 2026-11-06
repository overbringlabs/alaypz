defmodule Alaypz.Replay do
  @moduledoc """
  Deterministic replay of a recorded game.

  A recording is the game's `seed` plus the applied inputs, each stamped with
  the number of gravity ticks done before it landed (`Alaypz.Games.Game`
  records these while running). The engine is a pure function of its seed and
  input order, so `run/3` rebuilds the exact final engine state: the replayed
  final board equals the persisted final board.

  Inputs are stored JSON-safe (`[tick, "left"]` — strings, not atoms) and are
  validated against the known action set before use. `AlaypzWeb.ReplayLive`
  steps games with `apply_at/3` one tick at a time.
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
    engine = Game.new(seed)
    engine = apply_at(engine, inputs, 0)
    do_run(engine, inputs, 0, ticks)
  end

  @doc """
  Applies every `inputs` entry stamped with exactly `tick` (in recording
  order) to `engine`. Malformed or unknown entries are ignored.
  """
  def apply_at(engine, inputs, tick) do
    for item <- inputs,
        [t, action] = item,
        t == tick,
        action in action_strings(),
        reduce: engine do
      acc -> Game.apply(acc, String.to_existing_atom(action))
    end
  end

  defp action_strings, do: Enum.map(@actions, &to_string/1)

  defp do_run(engine, inputs, tick, total) do
    if Game.playing?(engine) and tick < total do
      # An input stamped with `n` landed after the n-th tick.
      engine = Game.tick(engine)
      engine = apply_at(engine, inputs, tick + 1)
      do_run(engine, inputs, tick + 1, total)
    else
      engine
    end
  end
end
