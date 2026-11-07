defmodule AlaypzWeb.GameCard do
  @moduledoc """
  One card per live game in the lobby; the component id is the player's
  unique name. The card renders a live mini-canvas of its game (the
  `.AlaypzCanvas` hook in card mode, fed by `alaypz-card-frame` events) so
  every ongoing game is visible without clicking.

  Components are not processes, so the card does not subscribe to anything:
  it self-hydrates from the game process once, and the lobby view pushes every
  `lobby` broadcast (with the full payload) here via `send_update/3`. A
  reconnecting broadcast carries no payload and must not clobber the
  last-known board.

  LV 1.2 lifecycle: `mount/1` runs before the parent's assigns arrive — they
  arrive in `update/2` (and in `render/1` directly), so `@name`/`@focused`
  come from the parent and the rest from the socket.
  """
  use AlaypzWeb, :live_component

  alias Alaypz.Game
  alias Alaypz.Games
  alias Alaypz.Players
  alias AlaypzWeb.FocusedGame

  def mount(socket) do
    {:ok,
     socket
     |> assign(:payload, nil)
     |> assign(:score, nil)
     |> assign(:status, nil)
     |> assign(:reconnecting, false)
     |> assign(:focused, false)
     |> assign(:last_frame, nil)
     |> assign(:last_name, nil)}
  end

  def update(%{name: name} = assigns, socket) do
    socket = assign(socket, :name, name)

    socket =
      if name != socket.assigns.last_name do
        # A newly added card: read the game process once.
        state = fetch_state(name)
        payload = state && Game.payload(state.game)

        socket
        |> assign(:payload, payload)
        |> assign(:score, state && state.game.score)
        |> assign(:status, state && state.status)
        |> assign(:reconnecting, false)
        |> assign(:last_name, name)
        |> assign(:last_frame, nil)
      else
        assign(socket, Map.drop(assigns, [:name]))
      end

    {:ok, push_if_changed(socket)}
  end

  # Pushes from the lobby view (payload/status per engine change; the
  # reconnecting broadcast has no payload — keep the last-known board).
  def update(assigns, socket) do
    {payload, assigns} = Map.pop(assigns, :payload)
    socket = assign(socket, assigns)
    socket = if payload, do: assign(socket, :payload, payload), else: socket
    {:ok, push_if_changed(socket)}
  end

  # Feed the card canvas when the state actually changed, so no-op renders
  # don't re-push the same frame.
  defp push_if_changed(socket) do
    frame_key = {socket.assigns.payload, socket.assigns.status}

    if frame_key != socket.assigns.last_frame do
      socket
      |> push_event("alaypz-card-frame", %{
        name: socket.assigns.name,
        frame: FocusedGame.frame(socket.assigns.payload, socket.assigns.status)
      })
      |> assign(:last_frame, frame_key)
    else
      socket
    end
  end

  def render(assigns) do
    ~H"""
    <button
      type="button"
      id={"card-#{@name}"}
      phx-click="focus"
      phx-value-name={@name}
      class={[
        "relative flex w-full flex-col gap-2.5 rounded-xl border p-3 text-left transition",
        if(@focused,
          do: "border-cyan-400/70 bg-cyan-400/10 shadow-[0_0_28px_rgba(0,229,255,0.22)]",
          else:
            "border-base-300 bg-base-100 hover:border-cyan-400/60 hover:bg-base-200/60 hover:shadow-[0_0_20px_rgba(0,229,255,0.14)]"
        ),
        "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/70"
      ]}
    >
      <span class="flex items-center justify-between gap-2">
        <span
          id={"card-name-#{@name}"}
          class="truncate text-sm font-semibold text-base-content"
        >
          {@name}
        </span>
        <.chip status={@status} reconnecting={@reconnecting} />
      </span>

      <span class="alaypz-board overflow-hidden rounded-md border border-base-300">
        <canvas
          id={"card-canvas-#{@name}"}
          phx-hook="AlaypzCanvas"
          phx-update="ignore"
          data-card
          data-name={@name}
          class="block"
        ></canvas>
      </span>

      <span class="flex items-baseline justify-between">
        <span class="text-xs uppercase tracking-wider text-base-content/60">score</span>
        <span
          id={"card-score-#{@name}"}
          class="text-lg font-semibold text-cyan-600 dark:text-cyan-300"
        >
          {@score || 0}
        </span>
      </span>

      <span class={[
        "absolute -top-1.5 right-3 rounded-full border px-2 py-px text-[0.625rem] font-bold uppercase tracking-wider",
        if(@focused,
          do: "border-cyan-400 bg-cyan-400/20 text-cyan-700 dark:text-cyan-200",
          else: "hidden border-base-300 bg-base-200 text-base-content/60"
        )
      ]}>
        focused
      </span>
    </button>
    """
  end

  defp fetch_state(name) do
    case Players.get_by_name(name) do
      nil -> nil
      player -> Games.state(player)
    end
  end
end
