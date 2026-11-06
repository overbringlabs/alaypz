defmodule AlaypzWeb.FocusedGame do
  @moduledoc """
  The focused game surface: a `.AlaypzCanvas` canvas (neon, tweened, glow)
  fed by server-computed frames via `push_event/3`, plus a text scoreboard.
  Every engine state change (view `send_update`) pushes a JSON-safe frame to
  the canvas hook; the hook tweens between the last two frames so players
  and spectators see the same authoritative state.

  LV 1.2 lifecycle: `mount/1` runs before the parent's assigns arrive —
  `@name` comes from the parent (render/update); `@payload`/`@status` from
  the socket, seeded on name changes and refreshed by view pushes.
  """
  use AlaypzWeb, :live_component

  alias Alaypz.Game
  alias Alaypz.Game.Pieces
  alias Alaypz.Games
  alias Alaypz.Players

  def mount(socket) do
    {:ok,
     socket
     |> assign(:payload, nil)
     |> assign(:status, nil)
     |> assign(:last_frame, nil)
     |> assign(:last_name, nil)}
  end

  def update(%{name: name} = assigns, socket) do
    socket =
      socket
      |> assign(:name, name)
      |> assign(:spectating, Map.get(assigns, :spectating, false))
      |> assign(:show_unfocus, Map.get(assigns, :show_unfocus, true))
      |> assign(:fit_height, Map.get(assigns, :fit_height, false))

    socket =
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

    {:ok, push_if_changed(socket)}
  end

  # `send_update` pushes (payload/status from the lobby view) arrive without
  # the parent's assigns — they carry only the pushed keys.
  def update(assigns, socket) do
    {:ok, push_if_changed(assign(socket, Map.delete(assigns, :name)))}
  end

  # Feed the canvas when the state actually changed, so no-op renders don't
  # re-push the same frame.
  defp push_if_changed(socket) do
    frame_key = {socket.assigns.payload, socket.assigns.status}

    if frame_key != socket.assigns.last_frame do
      socket
      |> push_event("alaypz-frame", frame(socket.assigns.payload, socket.assigns.status))
      |> assign(:last_frame, frame_key)
    else
      socket
    end
  end

  def render(assigns) do
    ~H"""
    <div
      id="focused-game"
      class="flex flex-wrap gap-6 rounded-xl border border-cyan-500/30 bg-base-100 p-5 shadow-sm max-lg:flex-col-reverse max-lg:gap-4 max-lg:p-3"
    >
      <div
        id="focused-board"
        class="alaypz-board rounded-lg border border-cyan-400/40 p-2 shadow-[0_0_24px_rgba(0,229,255,0.15)] max-lg:w-fit max-lg:self-center"
      >
        <canvas
          id="focused-canvas"
          phx-hook="AlaypzCanvas"
          phx-update="ignore"
          data-cols="10"
          data-rows="20"
          data-cell="28"
          data-fit-height={if @fit_height, do: "", else: nil}
          class="block"
        >
          {AlaypzWeb.Board.text(@payload && @payload.board)}
        </canvas>
      </div>

      <div class="min-w-52 flex-1">
        <div class="flex flex-wrap items-center justify-between gap-3">
          <span id="focused-name" class="text-base font-bold text-base-content lg:text-xl">
            {@name}
          </span>
          <span class="flex items-center gap-2">
            <.chip status={@status} />
            <%= if @show_unfocus do %>
              <button
                type="button"
                id="unfocus-button"
                phx-click="unfocus"
                class="cursor-pointer rounded-lg border border-base-300 px-3 py-1 text-xs font-semibold text-base-content/80 transition hover:border-rose-400/60 hover:text-rose-500"
              >
                Unfocus
              </button>
            <% end %>
          </span>
        </div>

        <dl class="mt-4 grid grid-cols-2 gap-x-8 gap-y-1.5 text-sm max-lg:grid-cols-3 max-lg:gap-x-4 max-lg:gap-y-0.5">
          <%!-- status + piece rows stay on desktop; mobile keeps the
               compact score/lines/level rows only --%>
          <div class="hidden justify-between gap-2 lg:flex">
            <dt class="uppercase tracking-wider text-base-content/60">status</dt>
            <dd id="focused-status" class="text-base-content/80">{status_label(@status)}</dd>
          </div>
          <div class="flex justify-between gap-2">
            <dt class="uppercase tracking-wider text-base-content/60">score</dt>
            <dd id="focused-score" class="font-semibold text-cyan-600 dark:text-cyan-300">
              {(@payload && @payload.score) || 0}
            </dd>
          </div>
          <div class="flex justify-between gap-2">
            <dt class="uppercase tracking-wider text-base-content/60">lines</dt>
            <dd class="text-base-content/80">{(@payload && @payload.lines) || 0}</dd>
          </div>
          <div class="flex justify-between gap-2">
            <dt class="uppercase tracking-wider text-base-content/60">level</dt>
            <dd class="text-base-content/80">{(@payload && @payload.level) || 1}</dd>
          </div>
          <div class="hidden justify-between gap-2 lg:flex">
            <dt class="uppercase tracking-wider text-base-content/60">piece</dt>
            <dd id="focused-piece" class="text-base-content/80">{piece_text(@payload)}</dd>
          </div>
        </dl>

        <%= if @spectating do %>
          <div class="mt-6 rounded-lg border border-amber-400/30 bg-base-200/60 p-4">
            <h3 class="mb-2 text-xs font-bold uppercase tracking-widest text-amber-600 dark:text-amber-400">
              Spectating
            </h3>
            <p class="text-sm text-base-content/70">
              You can watch this game, but only its owner can play it. Claim
              your own name and press Start to play your own game.
            </p>
          </div>
        <% else %>
          <%!-- desktop only: the mobile play screen is the board + the
               on-screen touch controls, no legend --%>
          <div class="mt-6 hidden rounded-lg border border-base-300/60 bg-base-200/60 p-4 lg:block">
            <h3 class="mb-3 text-xs font-bold uppercase tracking-widest text-cyan-600 dark:text-cyan-400">
              Controls
            </h3>
            <.rows />
            <p class="mt-4 text-xs text-base-content/60">
              Arrows move and drop · Z/X rotate · C hold — the on-screen
              buttons do the same.
            </p>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  # --- frame construction (JSON-safe: tuples become lists) ----------------

  # A single frame for the canvas hooks: absolute piece/ghost cells, box
  # position for the tween, queue/hold shapes, and the terminal status.
  # Shared by the focused surface and the lobby cards.
  def frame(nil, status) do
    %{
      board: nil,
      cells: nil,
      ghost: nil,
      piece: nil,
      piece_id: nil,
      piece_state: nil,
      queue: [],
      hold: nil,
      lines: 0,
      score: 0,
      level: 1,
      status: status
    }
  end

  def frame(payload, status) do
    %{
      board: payload.board,
      cells: cells_list(payload.cells),
      ghost: cells_list(payload.ghost),
      piece: piece_pos_list(payload.piece),
      piece_id: payload.piece && to_string(payload.piece.id),
      piece_state: payload.piece && payload.piece.state,
      queue: Enum.map(payload.queue, fn id -> %{id: to_string(id), cells: box_cells(id)} end),
      hold: if(payload.hold, do: %{id: to_string(payload.hold), cells: box_cells(payload.hold)}),
      lines: payload.lines || 0,
      score: payload.score || 0,
      level: payload.level || 1,
      status: status
    }
  end

  defp cells_list(nil), do: nil
  defp cells_list(cells), do: Enum.map(cells, fn {x, y} -> [x, y] end)

  defp piece_pos_list(nil), do: nil
  defp piece_pos_list(%{pos: {x, y}}), do: [x, y]

  defp box_cells(id) do
    Enum.map(Pieces.cells(id, 0), fn {x, y} -> [x, y] end)
  end

  # --- text fallbacks ------------------------------------------------------

  defp piece_text(%{piece: %{id: id, pos: {x, y}}}), do: "#{id} @ #{x},#{y}"
  defp piece_text(%{}), do: "—"

  defp status_label(nil), do: "no game"
  defp status_label(status), do: to_string(status)
end
