defmodule Alaypz.Games.Game do
  @moduledoc """
  One process per active game. Server-authoritative: the engine state
  (`Alaypz.Game`) lives here, a tick loop applies gravity at the level's
  fall interval, and every change broadcasts to the `game:<name>` topic and
  the `"lobby"` topic for the live cards.

  Lifecycle: `:playing` -> `:finished` (top-out) or `:interrupted` (the
  owner's connection dropped and the grace window elapsed). The process
  stays alive after a terminal state so the finished board remains
  observable; `Alaypz.Games.stop/1` ends it.
  """

  use GenServer

  alias Alaypz.Game

  # --- client API --------------------------------------------------------

  def start_link(name, player_id, seed) do
    GenServer.start_link(__MODULE__, {name, player_id, seed})
  end

  @doc "Sends an input on behalf of `caller`: `:left`, `:right`, `:cw`, `:ccw`, `:soft`, `:hard`, `:hold`. Only the process attached via `attach/2` is accepted — this is the owner gate."
  def input(pid, action, caller), do: GenServer.cast(pid, {:input, action, caller})

  @doc "Attaches the owner connection (monitored; its death starts the grace window)."
  def attach(pid, owner), do: GenServer.cast(pid, {:attach, owner})

  @doc "Full state: `%{name, player_id, status, game, seed, tick, inputs, owner, …}`."
  def state(pid), do: GenServer.call(pid, :state)

  # --- GenServer ----------------------------------------------------------

  @impl true
  def init({name, player_id, seed}) do
    state = %{
      name: name,
      player_id: player_id,
      status: :playing,
      game: Game.new(seed),
      seed: seed,
      tick: 0,
      inputs: [],
      owner: nil,
      owner_ref: nil,
      grace_ref: nil
    }

    register(name)
    {:ok, schedule(broadcast(state))}
  end

  @impl true
  # Only the attached owner may drive the game: inputs cast by any other
  # process (e.g. a spectator's lobby view) are dropped.
  def handle_cast({:input, action, caller}, %{status: :playing, owner: caller} = state)
      when caller != nil do
    game = apply_input(state.game, action)

    if game == state.game do
      {:noreply, state}
    else
      # Replay recording: an input that changed state is remembered at the
      # number of gravity ticks done so far (it landed after that many ticks).
      state = %{state | inputs: state.inputs ++ [{state.tick, action}]}

      if Game.playing?(game) do
        {:noreply, broadcast(%{state | game: game})}
      else
        {:noreply, end_game(%{state | game: game}, :finished)}
      end
    end
  end

  def handle_cast({:input, _action, _caller}, state), do: {:noreply, state}

  def handle_cast({:attach, owner}, state) do
    {:noreply, broadcast(monitor(clear_grace(state, true), owner))}
  end

  @impl true
  def handle_call(:state, _from, state), do: {:reply, state, state}

  @impl true
  def handle_info(:tick, %{status: :playing} = state) do
    # `tick` counts gravity ticks done so far — the replay clock.
    state = %{state | tick: state.tick + 1, game: Game.tick(state.game)}

    if Game.playing?(state.game) do
      {:noreply, schedule(broadcast(state))}
    else
      {:noreply, end_game(state, :finished)}
    end
  end

  def handle_info(:tick, state), do: {:noreply, state}

  # The owner connection died (tab closed): start the grace window. If the
  # owner re-attaches before it expires, the window is cancelled. The lobby
  # gets a `reconnecting` signal so cards can show the grace state.
  def handle_info({:DOWN, ref, :process, _owner, _reason}, state) do
    if ref != Map.get(state, :owner_ref) do
      {:noreply, state}
    else
      state = schedule_grace(%{state | owner: nil, owner_ref: nil})
      broadcast_reconnecting(state)
      {:noreply, state}
    end
  end

  def handle_info(:grace_expired, %{status: :playing, owner: nil} = state) do
    {:noreply, end_game(state, :interrupted)}
  end

  def handle_info(:grace_expired, state), do: {:noreply, state}

  # --- internals ----------------------------------------------------------

  # A previous game's registration lingers until the registry processes its
  # DOWN. Retry until the slot is free; never stop a process here, since a
  # reused pid could belong to an unrelated process.
  defp register(name) do
    1..50
    |> Enum.reduce_while(:ok, fn _, _ ->
      case Registry.register(Alaypz.Games.Registry, name, nil) do
        {:ok, _} ->
          {:halt, :ok}

        {:error, {:already_registered, _}} ->
          Process.sleep(2)
          {:cont, nil}
      end
    end)
    |> case do
      :ok -> :ok
      _ -> {:stop, :register_failed}
    end
  end

  defp apply_input(game, action), do: Game.apply(game, action)

  defp schedule(state) do
    Process.send_after(self(), :tick, tick_interval_ms(state.game))
    state
  end

  defp tick_interval_ms(game) do
    Application.get_env(:alaypz, :tick_interval_ms) || Game.falling_interval_ms(game.level)
  end

  defp monitor(state, owner) when is_pid(owner) do
    %{state | owner: owner, owner_ref: Process.monitor(owner)}
  end

  defp schedule_grace(state) do
    ms = Application.get_env(:alaypz, :grace_ms, 10_000)
    %{state | grace_ref: Process.send_after(self(), :grace_expired, ms)}
  end

  defp clear_grace(state, cancel?) do
    grace_ref = Map.get(state, :grace_ref)

    if cancel? and grace_ref do
      Process.cancel_timer(grace_ref)
    end

    Map.put(state, :grace_ref, nil)
  end

  defp end_game(state, reason) do
    state = %{state | status: reason}
    persist(state)
    broadcast(state)
  end

  defp persist(%{
         status: reason,
         player_id: player_id,
         game: game,
         seed: seed,
         tick: tick,
         inputs: inputs
       }) do
    end_reason = if(reason == :interrupted, do: "interrupted", else: "finished")

    # Replay = the deterministic seed + every applied input stamped with the
    # gravity-tick count it landed after. String keys: `:map` round-trips
    # through JSON.
    replay = %{
      "seed" => seed,
      "ticks" => tick,
      "inputs" => Enum.map(inputs, fn {t, action} -> [t, to_string(action)] end)
    }

    case Alaypz.Scores.record(%{
           player_id: player_id,
           score: game.score,
           lines: game.lines,
           level: game.level,
           end_reason: end_reason,
           board: Alaypz.Scores.encode_board(game.board),
           seed: seed,
           replay: replay
         }) do
      {:ok, _score} ->
        :ok

      {:error, changeset} ->
        require Logger

        Logger.error("score persist failed: #{inspect(changeset.errors)}")
        :ok
    end
  end

  # Fire-and-forget: the game topic keeps game subscribers in sync, the
  # lobby topic drives the live cards.
  defp broadcast(state) do
    payload = Game.payload(state.game)

    Phoenix.PubSub.broadcast(Alaypz.PubSub, "game:#{state.name}", %{
      type: :game,
      status: state.status,
      payload: payload
    })

    Phoenix.PubSub.broadcast(Alaypz.PubSub, "lobby", %{
      type: :lobby,
      name: state.name,
      score: state.game.score,
      status: state.status,
      payload: payload
    })

    state
  end

  defp broadcast_reconnecting(state) do
    Phoenix.PubSub.broadcast(Alaypz.PubSub, "lobby", %{
      type: :lobby,
      name: state.name,
      score: state.game.score,
      status: state.status,
      reconnecting: true
    })
  end
end
