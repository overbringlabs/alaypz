defmodule AlaypzWeb.ManifestoLiveTest do
  use AlaypzWeb.ConnCase

  import Phoenix.LiveViewTest

  test "renders the local AI manifesto from the markdown", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/manifesto")

    assert has_element?(view, "#manifesto-title", "Manifesto for local AI")
    refute has_element?(view, ".history-prose h1")
    assert has_element?(view, ".history-prose", "cat is out of the bag")
    assert has_element?(view, ".history-prose", "driver's seat")
    assert has_element?(view, ".history-prose a[href=\"https://overbring.com/books/cave/\"]")
  end

  test "the full page carries the footer link to the manifesto", %{conn: conn} do
    conn = get(conn, "/manifesto")

    assert conn.status == 200
    assert conn.resp_body =~ "/manifesto"
  end
end
