defmodule AlaypzWeb.GameCard do
  @moduledoc """
  One card per live game in the lobby; the component id is the player's
  unique name.

  Components are not processes, so the card does not subscribe to anything:
  it self-hydrates from the game process (on focus-name changes), and the
  lobby view pushes every `lobby` broadcast here via `send_update/3`.

  LV 1.2 lifecycle: `mount/1` runs before the parent's assigns arrive —
  they arrive in `update/2` (and in `render/1` directly), so `@name` comes
  from the parent and `@score`/`@status` from the socket.
  """
  use AlaypzWeb, :live_component

  alias Alaypz.Games
  alias Alaypz.Players

  def mount(socket) do
    {:ok,
     socket
     |> assign(:score, nil)
     |> assign(:status, nil)
     |> assign(:reconnecting, false)
     |> assign(:last_name, nil)}
  end

  def update(%{name: name} = assigns, socket) do
    socket = assign(socket, :name, name)

    new =
      if name != socket.assigns.last_name do
        # A newly focused/added card: read the game process once.
        state = fetch_state(name)

        socket
        |> assign(:score, state && state.game.score)
        |> assign(:status, state && state.status)
        |> assign(:reconnecting, false)
        |> assign(:last_name, name)
      else
        assign(socket, Map.drop(assigns, [:name]))
      end

    {:ok, new}
  end

  # Pushes from the lobby view for an existing card (no name change).
  def update(assigns, socket), do: {:ok, assign(socket, Map.delete(assigns, :name))}

  def render(assigns) do
    ~H"""
    <button
      type="button"
      id={"card-#{@name}"}
      phx-click="focus"
      phx-value-name={@name}
      class={[
        "flex flex-col gap-1 rounded-xl border px-3 py-2 text-left transition",
        "border-slate-700 bg-slate-800/60 hover:border-cyan-500 hover:bg-slate-800",
        if(@status in [:finished, :interrupted], do: "opacity-70", else: "opacity-100")
      ]}
    >
      <span class="flex items-center justify-between gap-2">
        <span id={"card-name-#{@name}"} class="truncate font-semibold text-slate-100">{@name}</span>
        <span class="text-sm text-slate-400">{card_label(@status, @reconnecting)}</span>
      </span>
      <span id={"card-score-#{@name}"} class="font-mono text-lg text-cyan-300">
        {@score || 0}
      </span>
    </button>
    """
  end

  defp card_label(status, reconnecting) do
    cond do
      reconnecting and status == :playing -> "reconnecting…"
      status == :finished -> "finished"
      status == :interrupted -> "interrupted"
      true -> "playing"
    end
  end

  defp fetch_state(name) do
    case Players.get_by_name(name) do
      nil -> nil
      player -> Games.state(player)
    end
  end
end
