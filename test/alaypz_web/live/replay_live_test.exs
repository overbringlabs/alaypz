defmodule AlaypzWeb.ReplayLiveTest do
  use AlaypzWeb.ConnCase

  require Phoenix.ConnTest
  import Phoenix.LiveViewTest

  alias Alaypz.Players
  alias Alaypz.Scores

  defp empty_board, do: List.duplicate(List.duplicate(nil, 10), 20)

  defp record(player, attrs \\ %{}) do
    Scores.record(
      Map.merge(
        %{
          player_id: player.id,
          score: 1,
          lines: 0,
          level: 1,
          end_reason: "finished",
          board: Scores.encode_board(empty_board())
        },
        attrs
      )
    )
  end

  test "unknown ids render the not-found state", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/replay/999_999_999")
    assert has_element?(view, "#replay-not-found")
    refute has_element?(view, "#replay-canvas")
  end

  test "non-numeric ids render the not-found state", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/replay/not-a-number")
    assert has_element?(view, "#replay-not-found")
  end

  test "sessions without a recording render the unavailable state", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("rp-unrec")
    {:ok, row} = record(player)

    {:ok, view, _html} = live(conn, "/replay/#{row.id}")
    assert has_element?(view, "#replay-unrecorded")
    refute has_element?(view, "#replay-canvas")
  end

  test "a recorded session renders the replay surface", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("rp-recorded")

    {:ok, row} =
      record(player, %{
        seed: 7,
        replay: %{"seed" => 7, "ticks" => 3, "inputs" => [[0, "hard"]]}
      })

    {:ok, view, _html} = live(conn, "/replay/#{row.id}")

    assert has_element?(view, "#replay-canvas")
    assert has_element?(view, "#replay-progress")
    assert has_element?(view, "#speed-1")
    assert has_element?(view, "#speed-2")
    assert has_element?(view, "#speed-5")
    assert has_element?(view, "#speed-10")
    assert has_element?(view, "#speed-20")
    assert has_element?(view, "#speed-50")
    assert has_element?(view, "#speed-100")
    refute has_element?(view, "#replay-complete")
    refute has_element?(view, "#replay-not-found")
    refute has_element?(view, "#replay-unrecorded")
  end

  test "inputs stamped at tick 0 apply before the first frame", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("rp-tick0")

    {:ok, row} =
      record(player, %{
        seed: 7,
        replay: %{"seed" => 7, "ticks" => 3, "inputs" => [[0, "hard"]]}
      })

    {:ok, view, _html} = live(conn, "/replay/#{row.id}")

    # The tick-0 hard drop scores before any gravity tick; without the fix
    # the first frame (and every step) misses it and the score stays 0.
    [_, captured] = Regex.run(~r/id="replay-score"[^>]*>\s*(\d+)/, render(view))
    assert String.to_integer(captured) > 0
  end
end
