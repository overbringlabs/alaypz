defmodule AlaypzWeb.ScoreCard do
  @moduledoc """
  One card per finished game: rank (optional — the top three glow), player
  name, score/lines/level, end reason, date, and the final board (a static
  mini-canvas fed by `data-board`). The card itself is the click target:
  the parent passes `phx-click`/`phx-value-*` through to the root element,
  and the name stays plain text so the click is unambiguous (the player page
  owns the name link).
  """
  use Phoenix.Component

  attr :score, :map, required: true, doc: "a Score with :player preloaded"
  attr :board_id, :string, required: true, doc: "DOM id for the board canvas"
  attr :rank, :integer, default: nil
  attr :clickable, :boolean, default: true
  attr :class, :string, default: ""
  attr :rest, :global, doc: "pass-through attributes (id, phx-click, phx-value-*)"

  def score_card(assigns) do
    assigns =
      assigns
      |> assign_new(:date, fn -> format_date(assigns.score.inserted_at) end)
      |> assign_new(:clickable, fn -> true end)

    ~H"""
    <article
      class={[
        "group rounded-xl border p-4 transition",
        if(@clickable,
          do:
            "cursor-pointer border-base-300 bg-base-100 hover:border-cyan-400/60 hover:bg-base-200/40",
          else: "border-base-300/60 bg-base-100"
        ),
        @class
      ]}
      {@rest}
    >
      <div class="flex items-start justify-between gap-4">
        <div class="min-w-0">
          <div class="flex items-baseline gap-2">
            <span
              :if={@rank}
              class={["text-xl font-bold leading-none", rank_class(@rank)]}
            >
              {@rank}
            </span>
            <h3 class="truncate text-sm font-semibold text-base-content">{@score.player.name}</h3>
          </div>
          <p class="mt-1 text-xs text-base-content/60">{@date}</p>
        </div>

        <span class="alaypz-board shrink-0 overflow-hidden rounded-md border border-base-300">
          <canvas
            id={@board_id}
            phx-hook="AlaypzCanvas"
            phx-update="ignore"
            data-static
            data-cell="10"
            data-board={@score.board}
            class="block"
          >
            {AlaypzWeb.Board.text(Alaypz.Scores.decode_board(@score.board))}
          </canvas>
        </span>
      </div>

      <dl class="mt-3 flex flex-wrap items-center gap-x-6 gap-y-1.5 text-sm">
        <div class="flex items-baseline gap-1.5">
          <dt class="text-xs uppercase tracking-wider text-base-content/60">score</dt>
          <dd class="font-semibold text-cyan-600 dark:text-cyan-300">{@score.score}</dd>
        </div>
        <div class="flex items-baseline gap-1.5">
          <dt class="text-xs uppercase tracking-wider text-base-content/60">lines</dt>
          <dd class="text-base-content/80">{@score.lines}</dd>
        </div>
        <div class="flex items-baseline gap-1.5">
          <dt class="text-xs uppercase tracking-wider text-base-content/60">level</dt>
          <dd class="text-base-content/80">{@score.level}</dd>
        </div>
        <dd class={[
          "ml-auto rounded-full border px-2 py-0.5 text-[11px] font-semibold uppercase tracking-wider",
          end_class(@score.end_reason)
        ]}>
          {@score.end_reason}
        </dd>
      </dl>
    </article>
    """
  end

  # Top three ranks glow gold / silver / bronze (theme-aware).
  defp rank_class(1),
    do: "text-amber-600 dark:text-amber-300 dark:[text-shadow:0_0_12px_rgba(252,211,77,0.5)]"

  defp rank_class(2),
    do: "text-slate-500 dark:text-slate-300 dark:[text-shadow:0_0_10px_rgba(203,213,225,0.4)]"

  defp rank_class(3),
    do: "text-orange-600 dark:text-orange-400 dark:[text-shadow:0_0_10px_rgba(251,146,60,0.4)]"

  defp rank_class(_), do: "text-base-content/50"

  defp end_class("finished"),
    do: "border-violet-400/40 bg-violet-400/10 text-violet-700 dark:text-violet-300"

  defp end_class(_), do: "border-rose-400/40 bg-rose-400/10 text-rose-700 dark:text-rose-300"

  defp format_date(nil), do: ""

  defp format_date(date) do
    Calendar.strftime(date, "%Y-%m-%d %H:%M")
  end
end
