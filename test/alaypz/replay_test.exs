defmodule Alaypz.ReplayTest do
  # The recording test drives a real game process (like games_test.exs), so
  # this module shares the repo sandbox; the pure `Replay.run/3` tests don't
  # touch it.
  use Alaypz.DataCase
  @moduletag :repo_sandbox

  alias Alaypz.{Game, Games, Players, Replay, Scores}

  # --- pure replay ---------------------------------------------------------

  test "replaying the same recording twice gives the same game" do
    inputs = [[0, "left"], [1, "left"], [1, "hard"], [2, "hard"]]
    final1 = Replay.run(42, 5, inputs)
    final2 = Replay.run(42, 5, inputs)

    assert final1.board == final2.board
    assert final1.score == final2.score
    assert final1.lines == final2.lines
  end

  test "unknown actions are ignored" do
    final = Replay.run(42, 3, [[0, "banana"]])
    assert Game.playing?(final)
    # Identical to a run with no inputs at all.
    assert final.board == Replay.run(42, 3, []).board
  end

  test "a recording of all hard drops tops the game out before the clock ends" do
    inputs = Enum.map(0..29, fn n -> [n, "hard"] end)
    final = Replay.run(7, 500, inputs)

    refute Game.playing?(final)
  end

  # --- input dispatch -------------------------------------------------------

  test "apply dispatches known actions and ignores unknown ones" do
    game = Game.new(42)
    # The spawn piece is mid-board, so a left move changes the state.
    assert Game.apply(game, :left) != game
    assert Game.apply(game, :unknown) == game
  end

  test "apply is a no-op on a terminal game" do
    terminal = Map.put(Game.new(42), :status, :topped_out)
    assert Game.apply(terminal, :left) == terminal
  end

  # --- end-to-end determinism ------------------------------------------------

  test "a replayed top-out reproduces the persisted final board" do
    {:ok, player, _secret} =
      Players.claim_name("RP-" <> Integer.to_string(System.unique_integer([:positive])))

    {:ok, _pid} = Games.start_game(player, 7)
    Games.attach(player, self())
    on_exit(fn -> Games.stop(player) end)

    Games.subscribe_game(player)

    receive do
      %{type: :game} -> :ok
    after
      500 -> flunk("no init broadcast")
    end

    for _ <- 1..30 do
      Games.input(player, :hard)
    end

    receive do
      %{type: :game, status: :finished} -> :ok
    after
      2000 -> flunk("game never finished")
    end

    score = hd(Scores.list_for_player(player))
    assert score.seed == 7
    # A top-out from rapid hard-drops can finish before any gravity tick
    # fires — a zero-tick clock with inputs stamped at tick 0 is valid.
    assert %{"seed" => 7, "ticks" => ticks, "inputs" => inputs} = score.replay
    assert is_integer(ticks) and ticks >= 0
    assert [first | _] = inputs
    [t, action] = first
    assert is_integer(t) and is_binary(action)
    assert action in Enum.map(Replay.actions(), &to_string/1)

    # The strong check: the engine rebuilt from seed + inputs reaches exactly
    # the persisted final board (and a terminal state).
    final = Replay.run(score.seed, ticks, inputs)
    refute Game.playing?(final)
    assert Scores.encode_board(final.board) == score.board
  end
end
