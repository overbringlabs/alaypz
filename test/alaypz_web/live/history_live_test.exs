defmodule AlaypzWeb.HistoryLiveTest do
  use AlaypzWeb.ConnCase

  import Phoenix.LiveViewTest

  test "renders why this exists from the markdown", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/why")

    assert has_element?(view, "#why-title", "Why does this exist?")
    refute has_element?(view, ".history-prose h1")
    assert has_element?(view, ".history-prose", "Qwen 3.8-27B")

    # The footer is layout chrome, outside the LiveView subtree the
    # element queries scope to — the full page carries it (below).
  end

  test "the full page carries the Overbring footer", %{conn: conn} do
    conn = get(conn, "/why")

    assert conn.status == 200
    assert conn.resp_body =~ "https://overbring.com"
    assert conn.resp_body =~ "/images/overbring.webp"
  end

  test "every page carries the OpenGraph meta", %{conn: conn} do
    conn = get(conn, "/why")
    body = conn.resp_body

    assert body =~ ~s(property="og:site_name" content="Alaypz")
    assert body =~ ~s(property="og:type" content="website")
    # The per-page title from the :page_title assign, suffixed — same
    # string in the document title and og:title.
    suffix = " · a Qwen3.8-27B experiment by OVERBRING Labs"
    assert body =~ ~s(property="og:title" content="Why does this exist?#{suffix}")
    assert body =~ ~s(data-default="Why does this exist?#{suffix}")
    assert body =~ ~s(property="og:description")
    assert body =~ ~s(name="twitter:card" content="summary_large_image")

    # og:url / og:image are absolute, built from the request host.
    assert body =~ ~s(property="og:url" content="http://www.example.com/why")
    assert body =~ ~s(content="http://www.example.com/images/og/og-image.png")
    assert body =~ ~s(property="og:image:width" content="1200")
    assert body =~ ~s(property="og:image:height" content="630")
  end
end
