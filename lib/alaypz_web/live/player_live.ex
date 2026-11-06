defmodule AlaypzWeb.PlayerLive do
  @moduledoc """
  `/u/:player_name`: that player's finished or interrupted games, score
  desc, each with its final board. The route is declared last in the
  router, so any unknown `/u/<name>` path also lands here and renders
  the not-found state for the given name.
  """
  use AlaypzWeb, :live_view

  alias Alaypz.Players
  alias Alaypz.Players.Player
  alias Alaypz.Scores

  @impl true
  def mount(%{"player_name" => name}, _session, socket) do
    player = Players.get_by_name(name)

    socket =
      case player do
        nil ->
          assign(socket, player: nil, name: name, results: [])

        %Player{} ->
          assign(socket, player: player, name: name, results: Scores.list_for_player(player))
      end

    {:ok, socket}
  end
end
