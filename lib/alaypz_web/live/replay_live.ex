defmodule AlaypzWeb.ReplayLive do
  @moduledoc """
  `/replay/:id`: replays a recorded session by running a fresh, deterministic
  engine at the recorded speed. The view owns its own engine instance (this
  is *not* routed through `Games.input` — there is no live game here, only
  the recording: seed + tick-stamped inputs).

  A `:step` self-message advances one gravity tick (plus the inputs stamped
  at that tick), pushes the frame to the `.AlaypzCanvas` hook (`replay-frame`)
  and reschedules at `falling_interval_ms(level) / speed`. Speed changes
  apply from the next scheduled step. The replay stops when the engine ends
  or the recording's tick count is reached.
  """
  use AlaypzWeb, :live_view

  alias Alaypz.{Game, Replay, Scores}
  alias AlaypzWeb.FocusedGame

  @speeds [1, 2, 5, 10]

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    # Every key the template touches is assigned in all states — HEEx `@key`
    # is a strict map access, so unassigned keys would raise.
    base =
      socket
      |> assign(:score, nil)
      |> assign(:replay, nil)
      |> assign(:engine, nil)
      |> assign(:speed, 1)
      |> assign(:tick, 0)
      |> assign(:total, 0)
      |> assign(:done, true)
      |> assign(:frame, nil)
      |> assign(:not_found, false)
      |> assign(:unrecorded, false)

    case Scores.get(parse_id(id)) do
      nil ->
        {:ok, assign(base, :not_found, true)}

      %Scores.Score{} = score ->
        case score.replay do
          nil ->
            {:ok, base |> assign(:score, score) |> assign(:unrecorded, true)}

          replay ->
            engine = Game.new(replay["seed"])

            socket =
              base
              |> assign(:score, score)
              |> assign(:replay, replay)
              |> assign(:engine, engine)
              |> assign(:tick, 0)
              |> assign(:total, replay["ticks"])
              |> assign(:done, false)
              |> assign(:frame, FocusedGame.frame(Game.payload(engine), "playing"))

            if connected?(socket) do
              {:ok, schedule_step(socket)}
            else
              {:ok, socket}
            end
        end
    end
  end

  # One replay step: a gravity tick, then the inputs stamped at that tick.
  @impl true
  def handle_info(:step, %{assigns: %{done: true}} = socket), do: {:noreply, socket}

  def handle_info(:step, socket) do
    tick = socket.assigns.tick + 1
    engine = Game.tick(socket.assigns.engine)
    engine = Replay.apply_at(engine, socket.assigns.replay["inputs"], tick)

    done = !Game.playing?(engine) or tick >= socket.assigns.total

    socket =
      socket
      |> assign(:engine, engine)
      |> assign(:tick, tick)
      |> assign(:done, done)
      |> assign(:frame, FocusedGame.frame(Game.payload(engine), frame_status(engine, socket)))

    socket =
      if done do
        push_event(socket, "replay-frame", socket.assigns.frame)
      else
        socket
      end

    if done do
      {:noreply, socket}
    else
      {:noreply, schedule_step(push_event(socket, "replay-frame", socket.assigns.frame))}
    end
  end

  # Speed: 1x/2x/5x/10x. The still-pending step keeps its old pace; the next
  # scheduled step uses the new one.
  @impl true
  def handle_event("speed", %{"speed" => speed}, socket) do
    speed =
      case Integer.parse(speed) do
        {n, _} -> n
        :error -> 1
      end

    if speed in @speeds and !socket.assigns.done do
      {:noreply, assign(socket, :speed, speed)}
    else
      {:noreply, socket}
    end
  end

  # --- internals ---------------------------------------------------------

  defp parse_id(id) do
    case Integer.parse(id) do
      {n, _} -> n
      :error -> -1
    end
  end

  defp schedule_step(socket) do
    engine = socket.assigns.engine
    ms = max(10, div(Game.falling_interval_ms(engine.level), socket.assigns.speed))
    Process.send_after(self(), :step, ms)
    socket
  end

  # The hook draws the game-over overlay for "finished"/"interrupted":
  # report the session's real end reason once the engine ends.
  defp frame_status(engine, socket) do
    if Game.playing?(engine), do: "playing", else: socket.assigns.score.end_reason
  end
end
