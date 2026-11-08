defmodule AlaypzWeb.ManifestoLiveTest do
  use AlaypzWeb.ConnCase

  import Phoenix.LiveViewTest

  test "renders the local AI case from the markdown", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/the-case-for-and-against-local-ai")

    assert has_element?(view, "#manifesto-title", "The case for and against local AI")
    assert has_element?(view, ".history-prose", "cat is out of the bag")
    assert has_element?(view, ".history-prose", "driver's seat")
    # The book link the rant points at.
    assert has_element?(view, ".history-prose a[href=\"https://overbring.com/books/cave/\"]")
    # The byline: the operator's name (linked) and the publication date.
    assert has_element?(view, "a[href=\"https://overbring.com/about/\"]", "Isaak Tsalicoglou")
    assert has_element?(view, "#case-byline", "2026-11-08")
  end

  test "the full page carries the footer link to the case", %{conn: conn} do
    conn = get(conn, "/the-case-for-and-against-local-ai")

    assert conn.status == 200
    assert conn.resp_body =~ "/the-case-for-and-against-local-ai"
  end
end
