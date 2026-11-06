defmodule AlaypzWeb.PlayLiveTest do
  use AlaypzWeb.ConnCase

  require Phoenix.ConnTest
  import Phoenix.LiveViewTest

  alias Alaypz.Games
  alias Alaypz.Players

  # LV 1.2 element-based event simulation: the element's phx-change /
  # phx-submit attribute names the handler, and the passed value (nested
  # under the form's `as: :identity` prefix) is merged into the form's
  # current DOM values.
  defp set_name(view, name) do
    render_change(element(view, "#name-form"), %{"identity" => %{"name" => name}})
  end

  defp submit_form(view) do
    render_submit(element(view, "#name-form"))
  end

  test "claims a name, starts a game, and shows the swipe-driven play surface",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, "/play")

    set_name(view, "alice-play")
    submit_form(view)

    assert has_element?(view, "#access-string")
    assert has_element?(view, "#access-string-value")
    assert has_element?(view, "#play-name")
    assert has_element?(view, "#play-section", "Claim a name and start a game")

    render_click(element(view, "#start-button"))

    assert has_element?(view, "#focused-name", "alice-play")
    assert has_element?(view, "#focused-canvas")
    # The board is the touch surface (swipes) — no button pad.
    assert has_element?(view, "#swipe-hint")
    refute has_element?(view, "#play-controls")

    on_exit(fn -> Games.stop(Players.get_by_name("alice-play")) end)
  end

  test "reloading /play re-attaches to a running game", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("reload-play")
    on_exit(fn -> Games.stop(player) end)
    Games.start_game(player, 5)

    # The name is already claimed (the browser's own, saved in
    # localStorage); submitting it re-attaches to the running game instead
    # of starting a fresh one.
    {:ok, view, _html} = live(conn, "/play")
    set_name(view, "reload-play")
    submit_form(view)

    assert has_element?(view, "#focused-name", "reload-play")
    assert has_element?(view, "#swipe-hint")

    # The name is this browser's own (already claimed) and the surface is
    # up: no reclaim-mode ceremony (access input) or notice.
    refute has_element?(view, "#play-access")
    refute has_element?(view, "#lobby-notice")
  end

  test "the play surface has no unfocus button (the player's game can't be released in place)", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, "/play")

    set_name(view, "noleave-play")
    submit_form(view)
    render_click(element(view, "#start-button"))
    assert has_element?(view, "#focused-game")
    refute has_element?(view, "#unfocus-button")

    on_exit(fn -> Games.stop(Players.get_by_name("noleave-play")) end)
  end

  test "keyboard acts only on the view's own game" do
    {:ok, player, _secret} = Players.claim_name("dora-play")
    on_exit(fn -> Games.stop(player) end)
    Games.start_game(player, 42)
    Games.attach(player, self())
    Games.subscribe_game(player)

    # A view focused on dora's game but owning a different name: its inputs
    # are skipped by the view gate (the piece keeps falling at x=3).
    spectator = %Phoenix.LiveView.Socket{
      assigns: %{
        form:
          Phoenix.Component.to_form(%{"name" => "victor-play", "access" => ""}, as: :identity),
        focused_name: "dora-play"
      }
    }

    {:noreply, _} =
      AlaypzWeb.PlayLive.handle_event("game-key", %{"key" => "ArrowLeft"}, spectator)

    refute_receive %{type: :game, payload: %{piece: %{pos: {2, _y}}}}, 400

    # The owning view's inputs pass the view gate and the process gate.
    owner = %Phoenix.LiveView.Socket{
      assigns: %{
        form: Phoenix.Component.to_form(%{"name" => "dora-play", "access" => ""}, as: :identity),
        focused_name: "dora-play"
      }
    }

    {:noreply, _} =
      AlaypzWeb.PlayLive.handle_event("game-key", %{"key" => "ArrowLeft"}, owner)

    assert_receive %{type: :game, payload: %{piece: %{pos: {2, _y}}}}, 500
  end

  test "an unknown key from a tampered client is ignored, not a crash" do
    {:ok, player, _secret} = Players.claim_name("tamper-play")
    on_exit(fn -> Games.stop(player) end)
    Games.start_game(player, 42)
    Games.attach(player, self())

    owner = %Phoenix.LiveView.Socket{
      assigns: %{
        form:
          Phoenix.Component.to_form(%{"name" => "tamper-play", "access" => ""}, as: :identity),
        focused_name: "tamper-play"
      }
    }

    {:noreply, _} =
      AlaypzWeb.PlayLive.handle_event("game-key", %{"key" => "F12"}, owner)
  end
end
