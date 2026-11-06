defmodule AlaypzWeb.LeaderboardLiveTest do
  use AlaypzWeb.ConnCase

  require Phoenix.ConnTest
  import Phoenix.LiveViewTest

  alias Alaypz.Players
  alias Alaypz.Scores

  defp empty_board, do: List.duplicate(List.duplicate(nil, 10), 20)

  defp top_row_board do
    empty_board()
    |> List.update_at(0, fn _ -> List.duplicate(:i, 10) end)
  end

  defp record(player, score) do
    Scores.record(%{
      player_id: player.id,
      score: score,
      lines: 2,
      level: 1,
      end_reason: "finished",
      board: Scores.encode_board(top_row_board())
    })
  end

  test "ranks games by score and draws the final board", %{conn: conn} do
    {:ok, p1, _secret} = Players.claim_name("lb-one")
    {:ok, p2, _secret} = Players.claim_name("lb-two")
    {:ok, top} = record(p1, 300)
    {:ok, low} = record(p2, 100)

    {:ok, view, _html} = live(conn, "/leaderboard")

    # Score desc: the 300 row precedes the 100 row.
    html = render(view)
    {top_pos, _size} = :binary.match(html, "lb-#{top.id}")
    {low_pos, _size} = :binary.match(html, "lb-#{low.id}")
    assert top_pos < low_pos
    assert has_element?(view, "#lb-#{top.id}", "lb-one")
    # The final board's filled top row is drawn.
    assert render(element(view, "#lb-#{top.id}")) =~ "iiiiiiiiii"
  end

  test "shows at most 10 games", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("lb-many")
    {:ok, lowest} = record(player, 1)
    {:ok, highest} = record(player, 11)

    for score <- 2..10 do
      record(player, score)
    end

    {:ok, view, _html} = live(conn, "/leaderboard")

    # 11 games exist; only the top 10 (score desc) are shown, so the
    # lowest-scoring row is the one missing.
    assert has_element?(view, "#lb-#{highest.id}")
    refute has_element?(view, "#lb-#{lowest.id}")
  end

  test "shows the empty state", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/leaderboard")
    assert has_element?(view, "#leaderboard-empty")
    refute has_element?(view, "#leaderboard")
  end

  test "clicking a card opens the session drawer; close removes it", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("lb-drawer")
    {:ok, row} = record(player, 300)

    {:ok, view, _html} = live(conn, "/leaderboard")
    refute has_element?(view, "#session-drawer")

    render_click(element(view, "#lb-#{row.id}"))

    assert has_element?(view, "#session-drawer", "lb-drawer")
    assert has_element?(view, "#session-board")
    # Recorded before replay existed: no replay action, a note instead.
    assert has_element?(view, "#session-replay-unavailable")
    refute has_element?(view, "#session-replay")

    render_click(element(view, "#session-close"))
    refute has_element?(view, "#session-drawer")
  end

  test "the drawer offers the replay action for recorded sessions", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("lb-replay")

    {:ok, recorded} =
      Scores.record(%{
        player_id: player.id,
        score: 500,
        lines: 3,
        level: 2,
        end_reason: "finished",
        board: Scores.encode_board(top_row_board()),
        seed: 7,
        replay: %{"seed" => 7, "ticks" => 3, "inputs" => [[0, "hard"]]}
      })

    {:ok, view, _html} = live(conn, "/leaderboard")
    render_click(element(view, "#lb-#{recorded.id}"))

    assert has_element?(view, "#session-drawer", "lb-replay")
    assert render(element(view, "#session-replay")) =~ ~r"href=\"/replay/#{recorded.id}\""
    refute has_element?(view, "#session-replay-unavailable")
  end
end
