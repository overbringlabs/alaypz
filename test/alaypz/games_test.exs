defmodule Alaypz.GamesTest do
  # DataCase runs the sandbox in shared mode, so the supervised game process
  # shares the owner's connection and its persisted scores are visible
  # (and rolled back) here.
  use Alaypz.DataCase
  @moduletag :repo_sandbox

  alias Alaypz.{Games, Players}

  setup do
    name = "GT-" <> Integer.to_string(System.unique_integer([:positive]))
    {:ok, player, _secret} = Players.claim_name(name)
    {:ok, player: player}
  end

  defp start_allowed(player, seed) do
    {:ok, _pid} = Games.start_game(player, seed)
    on_exit(fn -> Games.stop(player) end)
  end

  defp idle_owner() do
    spawn(fn ->
      receive do
        :kill -> :ok
      end
    end)
  end

  defp drain_game(label) do
    receive do
      %{type: :game} -> :ok
    after
      500 -> flunk("no game broadcast for #{label}")
    end
  end

  defp subscribe_lobby() do
    Phoenix.PubSub.subscribe(Alaypz.PubSub, "lobby")
  end

  # --- assertions are tick-robust: the 25 ms gravity ticks keep moving the
  # piece, so we assert invariants (x-coordinate, hold slot, score, floor)
  # rather than exact positions.

  test "left input moves the piece left", %{player: player} do
    start_allowed(player, 42)
    assert %{status: :playing, game: game} = Games.state(player)
    assert game.status == :playing

    Games.subscribe_game(player)
    drain_game("init")
    Games.input(player, :left)

    assert_receive %{type: :game, payload: %{piece: %{pos: {2, _y}}}}, 500
  end

  test "hard drop scores and respawns at the top", %{player: player} do
    start_allowed(player, 42)
    Games.subscribe_game(player)
    drain_game("init")

    Games.input(player, :hard)

    receive do
      %{type: :game, payload: %{score: score, piece: %{pos: {3, _y}}}} when score >= 2 ->
        :ok
    after
      500 -> flunk("no hard-drop broadcast with score >= 2")
    end
  end

  test "hold moves the current piece into the hold slot", %{player: player} do
    start_allowed(player, 42)
    Games.subscribe_game(player)
    drain_game("init")

    Games.input(player, :hold)

    receive do
      %{type: :game, payload: %{hold: held}} when held != nil ->
        :ok
    after
      500 -> flunk("no hold broadcast")
    end
  end

  test "gravity ticks move the piece to the floor", %{player: player} do
    start_allowed(player, 42)
    Games.subscribe_game(player)
    drain_game("init")

    # Every un-moved piece falls to the floor (ghost row) before locking.
    assert_receive %{type: :game, payload: %{piece: %{pos: {3, 18}}}}, 2000
  end

  test "top-out finishes the game and persists the final state", %{player: player} do
    start_allowed(player, 7)
    Games.subscribe_game(player)
    drain_game("init")

    for _ <- 1..30 do
      Games.input(player, :hard)
    end

    assert_receive %{type: :game, status: :finished, payload: %{score: score}}, 2000
    assert score > 0
    assert Games.state(player).status == :finished

    assert %{end_reason: "finished", board: board} = hd(Alaypz.Scores.list_for_player(player))
    assert String.length(board) == 200
  end

  test "owner disconnect interrupts after the grace window", %{player: player} do
    start_allowed(player, 42)
    Games.subscribe_game(player)
    subscribe_lobby()
    drain_game("init")

    owner = idle_owner()
    Games.attach(player, owner)
    drain_game("attach")

    name = player.name
    Process.exit(owner, :kill)

    assert_receive %{type: :lobby, name: ^name, reconnecting: true}, 500
    assert_receive %{type: :game, status: :interrupted}, 2000

    assert %{end_reason: "interrupted"} = hd(Alaypz.Scores.list_for_player(player))

    # The finished board stays observable on the live process.
    assert %{status: :interrupted, game: game} = Games.state(player)
    assert game.board != nil
  end

  test "re-attach within the grace window cancels the interrupt", %{player: player} do
    start_allowed(player, 42)
    Games.subscribe_game(player)
    subscribe_lobby()
    drain_game("init")

    owner1 = idle_owner()
    Games.attach(player, owner1)
    drain_game("attach1")

    name = player.name
    Process.exit(owner1, :kill)
    assert_receive %{type: :lobby, name: ^name, reconnecting: true}, 500

    owner2 = idle_owner()
    Games.attach(player, owner2)
    drain_game("attach2")

    # No interrupt fires while the grace window is cancelled.
    refute_receive %{type: :game, status: :interrupted}, 250

    # A fresh disconnect starts a fresh window.
    Process.exit(owner2, :kill)
    assert_receive %{type: :game, status: :interrupted}, 2000
  end

  test "stop ends the process and a fresh game can start", %{player: player} do
    start_allowed(player, 42)
    Games.stop(player)
    assert Games.state(player) == nil

    start_allowed(player, 43)
    assert Games.state(player).status == :playing
  end
end
