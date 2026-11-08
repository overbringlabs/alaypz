defmodule AlaypzWeb.HistoryLiveTest do
  use AlaypzWeb.ConnCase

  import Phoenix.LiveViewTest

  test "renders the development history from the markdown", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/history")

    assert has_element?(view, "#history-title", "Development history")
    refute has_element?(view, ".history-prose h1")
    assert has_element?(view, ".history-prose", "Qwen 3.8-27B")

    # The footer is layout chrome, outside the LiveView subtree the
    # element queries scope to — the full page carries it (below).
  end

  test "the full page carries the Overbring footer", %{conn: conn} do
    conn = get(conn, "/history")

    assert conn.status == 200
    assert conn.resp_body =~ "https://overbring.com"
    assert conn.resp_body =~ "/images/overbring.webp"
  end
end
