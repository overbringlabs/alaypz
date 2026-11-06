defmodule Alaypz.Games do
  @moduledoc """
  Starts and addresses the per-player game processes (`Alaypz.Games.Game`).
  One game per player at a time, keyed by the player's unique name.
  `start_game/2` restarts it.
  """

  alias Alaypz.Games.Game

  @supervisor Alaypz.Games.Supervisor

  @doc "Starts a fresh game for `player` (stops any running one first)."
  def start_game(player, seed \\ nil) do
    stop(player)

    # The child id is unique per attempt: a stopped game's supervisor slot is
    # released asynchronously, so reusing a fixed id (e.g. the name) races
    # with that and can report a stale pid as started. One game per player is
    # enforced by the registry (keyed by name) and by stopping first.
    #
    # `restart: :temporary`: a game is ended explicitly (`Alaypz.Games.stop`)
    # and must never be auto-restarted — a restarted "ghost" game would take
    # the registry name back, and rapid stop/start cycles would trip the
    # supervisor's restart intensity and shut it down.
    child_id = "#{player.name}-#{System.unique_integer([:positive])}"

    DynamicSupervisor.start_child(@supervisor, %{
      id: child_id,
      start:
        {Game, :start_link, [player.name, player.id, seed || System.unique_integer([:positive])]},
      restart: :temporary
    })
  end

  @doc "Stops the player's game, if one is running."
  def stop(player) do
    case Registry.lookup(Alaypz.Games.Registry, player.name) do
      # The registry entry can outlive the process for a moment; a dead pid
      # is already stopped.
      [{pid, _}] ->
        if Process.alive?(pid) do
          GenServer.stop(pid)
        end

        :ok

      [] ->
        :ok
    end
  end

  @doc "Sends an input on behalf of the calling process (no-op if none is running, or the caller is not the attached owner)."
  def input(player, action) do
    case Registry.lookup(Alaypz.Games.Registry, player.name) do
      [{pid, _}] -> Game.input(pid, action, self())
      [] -> :ok
    end
  end

  @doc "Attaches the owner connection to the game (no-op if none is running)."
  def attach(player, owner) do
    case Registry.lookup(Alaypz.Games.Registry, player.name) do
      [{pid, _}] -> Game.attach(pid, owner)
      [] -> :ok
    end
  end

  @doc "Full state of the player's game, or nil."
  def state(player) do
    case Registry.lookup(Alaypz.Games.Registry, player.name) do
      # The registry entry can outlive the process for a moment.
      [{pid, _}] ->
        if Process.alive?(pid) do
          try do
            Game.state(pid)
          rescue
            # The process died between the liveness check and the call.
            _ -> nil
          end
        else
          nil
        end

      [] ->
        nil
    end
  end

  @doc "Subscribes the calling process to the player's game broadcast topic."
  def subscribe_game(player) do
    Phoenix.PubSub.subscribe(Alaypz.PubSub, "game:#{player.name}")
  end
end
