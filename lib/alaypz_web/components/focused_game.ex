defmodule AlaypzWeb.FocusedGame do
  @moduledoc """
  The focused game surface: a compact text rendering of the last engine
  state pushed by the lobby view. Step 6 replaces the `<pre>` grid with the
  `.AlaypzCanvas` hook; the component contract (payload + status assigns)
  stays the same.

  LV 1.2 lifecycle: `mount/1` runs before the parent's assigns arrive —
  `@name` comes from the parent (render/update); `@payload`/`@status` from
  the socket, seeded on name changes and refreshed by view pushes.
  """
  use AlaypzWeb, :live_component

  alias Alaypz.Game
  alias Alaypz.Games
  alias Alaypz.Players

  def mount(socket) do
    {:ok,
     socket
     |> assign(:payload, nil)
     |> assign(:status, nil)
     |> assign(:last_name, nil)}
  end

  def update(%{name: name} = assigns, socket) do
    socket = assign(socket, :name, name)

    new =
      if name != socket.assigns.last_name do
        # A newly focused game: read the game process once.
        payload =
          case Players.get_by_name(name) do
            nil -> nil
            player -> Games.state(player) |> then(&(&1 && Game.payload(&1.game)))
          end

        socket
        |> assign(:payload, payload)
        |> assign(:status, nil)
        |> assign(:last_name, name)
      else
        assign(socket, Map.drop(assigns, [:name]))
      end

    {:ok, new}
  end

  # Pushes from the lobby view for the already-focused game.
  def update(assigns, socket), do: {:ok, assign(socket, Map.delete(assigns, :name))}

  def render(assigns) do
    ~H"""
    <div id="focused-game" class="rounded-xl border border-slate-700 bg-slate-900/60 p-4">
      <div class="mb-2 flex items-center justify-between gap-2">
        <h3 id="focused-name" class="font-semibold text-slate-100">{@name}</h3>
        <span id="focused-status" class="text-sm text-slate-400">
          {status_label(@status)}
        </span>
      </div>

      <div class="flex gap-6">
        <pre
          id="focused-board"
          class="font-mono text-[11px] leading-[14px] text-slate-300"
        >
          {board_text(@payload)}
        </pre>

        <dl class="space-y-1 text-sm">
          <div class="flex gap-2">
            <dt class="w-14 text-slate-500">score</dt>
            <dd id="focused-score" class="font-mono text-cyan-300">
              {(@payload && @payload.score) || 0}
            </dd>
          </div>
          <div class="flex gap-2">
            <dt class="text-slate-500">lines</dt>
            <dd class="font-mono">{(@payload && @payload.lines) || 0}</dd>
          </div>
          <div class="flex gap-2">
            <dt class="text-slate-500">level</dt>
            <dd class="font-mono">{(@payload && @payload.level) || 1}</dd>
          </div>
          <div class="flex gap-2">
            <dt class="text-slate-500">piece</dt>
            <dd id="focused-piece" class="font-mono">{piece_text(@payload)}</dd>
          </div>
        </dl>
      </div>
    </div>
    """
  end

  defp piece_text(%{piece: %{id: id, pos: {x, y}}}), do: "#{id} @ #{x},#{y}"
  defp piece_text(%{}), do: "—"

  defp board_text(nil), do: ""

  defp board_text(%{board: board}) do
    board
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn
        nil -> "·"
        id -> Atom.to_string(id)
      end)
      |> Enum.join()
    end)
    |> Enum.join("\n")
  end

  defp status_label(nil), do: "no game"
  defp status_label(status), do: to_string(status)
end
