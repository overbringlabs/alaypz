defmodule AlaypzWeb.PlayerLiveTest do
  use AlaypzWeb.ConnCase

  require Phoenix.ConnTest
  import Phoenix.LiveViewTest

  alias Alaypz.Players
  alias Alaypz.Scores

  defp record(player, score) do
    board = List.duplicate(List.duplicate(nil, 10), 20)

    Scores.record(%{
      player_id: player.id,
      score: score,
      lines: 1,
      level: 1,
      end_reason: "finished",
      board: Scores.encode_board(board)
    })
  end

  test "lists a player's games, score desc", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("pl-one")
    {:ok, top} = record(player, 500)
    {:ok, low} = record(player, 200)

    {:ok, view, _html} = live(conn, "/pl-one")

    assert has_element?(view, "#player-title", "pl-one")

    html = render(view)
    {top_pos, _size} = :binary.match(html, "ps-#{top.id}")
    {low_pos, _size} = :binary.match(html, "ps-#{low.id}")
    assert top_pos < low_pos
  end

  test "the name lookup is case-insensitive", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("pl-two")
    {:ok, _row} = record(player, 40)

    {:ok, view, _html} = live(conn, "/pl-TWO")

    assert has_element?(view, "#player-scores")
  end

  test "unknown names render the not-found state", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/no-such-player")

    assert has_element?(view, "#player-not-found", "no-such-player")
    refute has_element?(view, "#player-scores")
  end
end
