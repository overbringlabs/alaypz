defmodule AlaypzWeb.LeaderboardLive do
  @moduledoc """
  `/leaderboard`: the top 10 finished or interrupted games (score desc,
  ties broken by most recent), each with its final board. Static — the
  leaderboard is history, so it only changes when the page is visited;
  new games show up on the next load. Clicking a card opens the session
  drawer (complete data + the replay action); it is a view-local overlay,
  not a route.
  """
  use AlaypzWeb, :live_view

  alias Alaypz.Scores

  @impl true
  def mount(_params, _session, socket) do
    rows =
      Scores.list_top(10)
      |> Enum.with_index(1)
      |> Enum.map(fn {score, rank} -> Map.put(score, :rank, rank) end)

    {:ok, assign(socket, results: rows, session: nil)}
  end

  # Open the session drawer for a leaderboard card.
  @impl true
  def handle_event("open-session", %{"id" => id}, socket) do
    # Client-controlled param: parse, don't raise.
    case Integer.parse(id) do
      {n, _} ->
        score = Enum.find(socket.assigns.results, &(&1.id == n))
        {:noreply, assign(socket, :session, score)}

      :error ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_event("close-session", _, socket) do
    {:noreply, assign(socket, :session, nil)}
  end
end
