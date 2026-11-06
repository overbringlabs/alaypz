defmodule AlaypzWeb.LeaderboardLive do
  @moduledoc """
  `/leaderboard`: the top 10 finished or interrupted games (score desc,
  ties broken by most recent), each with its final board. Static — the
  leaderboard is history, so it only changes when the page is visited;
  new games show up on the next load.
  """
  use AlaypzWeb, :live_view

  alias Alaypz.Scores

  @impl true
  def mount(_params, _session, socket) do
    rows =
      Scores.list_top(10)
      |> Enum.with_index(1)
      |> Enum.map(fn {score, rank} -> Map.put(score, :rank, rank) end)

    {:ok, assign(socket, results: rows)}
  end

  # Top three ranks glow gold / silver / bronze.
  def rank_class(1), do: "text-amber-300 [text-shadow:0_0_12px_rgba(252,211,77,0.5)]"
  def rank_class(2), do: "text-slate-300 [text-shadow:0_0_10px_rgba(203,213,225,0.4)]"
  def rank_class(3), do: "text-orange-400 [text-shadow:0_0_10px_rgba(251,146,60,0.4)]"
  def rank_class(_), do: "text-slate-500"
end
