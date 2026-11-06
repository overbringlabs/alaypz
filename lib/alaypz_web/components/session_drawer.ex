defmodule AlaypzWeb.SessionDrawer do
  @moduledoc """
  The right-side session drawer (daisyUI drawer look: dimmed overlay +
  sliding `bg-base-100` panel). Shows the complete session data — player,
  score, lines, level, end reason, finished at, the final board — and the
  Replay action (`/replay/<id>`; sessions recorded before replay existed
  show a disabled note).

  The parent view owns the open/close state (`@session` assign) and handles
  the `close-session` event; this component renders the overlay (click to
  close) and the panel (X button closes).
  """
  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    endpoint: AlaypzWeb.Endpoint,
    router: AlaypzWeb.Router,
    statics: AlaypzWeb.static_paths()

  import AlaypzWeb.CoreComponents

  attr :session, :map, required: true, doc: "a Score with :player preloaded"
  attr :rank, :integer, default: nil

  def session_drawer(assigns) do
    assigns = assign_new(assigns, :date, fn -> format_date(assigns.session.inserted_at) end)

    ~H"""
    <div id="session-drawer" role="dialog" aria-modal="true" aria-label="Session details">
      <div class="fixed inset-0 z-40 bg-black/50" phx-click="close-session" aria-hidden="true"></div>

      <aside class="session-drawer-panel fixed right-0 top-0 z-50 flex h-full w-full max-w-md flex-col gap-5 overflow-y-auto border-l border-base-300 bg-base-100 p-5 shadow-2xl">
        <div class="flex items-start justify-between gap-3">
          <div class="min-w-0">
            <p class="text-xs uppercase tracking-wider text-base-content/60">Session</p>
            <h2 class="mt-1 flex items-baseline gap-2">
              <span :if={@rank} class="text-lg font-bold text-base-content/70">#{@rank}</span>
              <.link
                navigate={"/u/#{@session.player.name}"}
                class="truncate text-lg font-bold text-base-content transition hover:text-cyan-500"
              >
                {@session.player.name}
              </.link>
            </h2>
            <p class="mt-1 text-sm text-base-content/60">finished {@date}</p>
          </div>

          <button
            type="button"
            id="session-close"
            phx-click="close-session"
            aria-label="Close"
            class="rounded-lg border border-base-300 p-2 text-base-content/60 transition hover:border-rose-400/60 hover:text-rose-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/70"
          >
            <.icon name="hero-x-mark" class="size-5" />
          </button>
        </div>

        <dl class="grid grid-cols-3 gap-3 text-sm">
          <div class="rounded-lg border border-base-300/60 bg-base-200/50 p-3">
            <dt class="text-xs uppercase tracking-wider text-base-content/60">score</dt>
            <dd class="mt-1 text-xl font-semibold text-cyan-600 dark:text-cyan-300">
              {@session.score}
            </dd>
          </div>
          <div class="rounded-lg border border-base-300/60 bg-base-200/50 p-3">
            <dt class="text-xs uppercase tracking-wider text-base-content/60">lines</dt>
            <dd class="mt-1 text-xl font-semibold text-base-content">{@session.lines}</dd>
          </div>
          <div class="rounded-lg border border-base-300/60 bg-base-200/50 p-3">
            <dt class="text-xs uppercase tracking-wider text-base-content/60">level</dt>
            <dd class="mt-1 text-xl font-semibold text-base-content">{@session.level}</dd>
          </div>
        </dl>

        <div class="flex items-center justify-between gap-3">
          <span class={[
            "rounded-full border px-2 py-0.5 text-[11px] font-semibold uppercase tracking-wider",
            if(@session.end_reason == "finished",
              do: "border-violet-400/40 bg-violet-400/10 text-violet-700 dark:text-violet-300",
              else: "border-rose-400/40 bg-rose-400/10 text-rose-700 dark:text-rose-300"
            )
          ]}>
            {@session.end_reason}
          </span>
          <span class="text-xs text-base-content/60">final board</span>
        </div>

        <div class="alaypz-board rounded-lg border border-base-300 p-2">
          <canvas
            id="session-board"
            phx-hook="AlaypzCanvas"
            phx-update="ignore"
            data-static
            data-cell="14"
            data-board={@session.board}
            class="block"
          >
            {AlaypzWeb.Board.text(Alaypz.Scores.decode_board(@session.board))}
          </canvas>
        </div>

        <%!-- replay: only sessions recorded after the replay column exists --%>
        <div id="session-replay-box" class="mt-auto border-t border-base-300/60 pt-4">
          <%= if @session.replay do %>
            <a
              id="session-replay"
              href={~p"/replay/#{@session.id}"}
              class="inline-flex w-full items-center justify-center gap-2 rounded-lg bg-cyan-600 px-4 py-2 text-sm font-semibold text-white transition hover:bg-cyan-500 hover:shadow-[0_0_20px_rgba(0,229,255,0.35)] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/70"
            >
              <.icon name="hero-play" class="size-4" /> Replay this session
            </a>
          <% else %>
            <p id="session-replay-unavailable" class="text-sm text-base-content/60">
              Replay not recorded for this session.
            </p>
          <% end %>
        </div>
      </aside>
    </div>
    """
  end

  defp format_date(nil), do: ""

  defp format_date(date) do
    Calendar.strftime(date, "%Y-%m-%d %H:%M")
  end
end
