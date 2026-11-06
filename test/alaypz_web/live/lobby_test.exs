defmodule AlaypzWeb.LobbyLiveTest do
  use AlaypzWeb.ConnCase

  require Phoenix.ConnTest
  import Phoenix.LiveViewTest

  alias Alaypz.Games
  alias Alaypz.Players

  # LV 1.2 element-based event simulation: the element's phx-change /
  # phx-submit / phx-click attribute names the handler, and the passed value
  # (nested under the form's `as: :identity` prefix) is merged into the form's
  # current DOM values.
  defp set_name(view, name) do
    render_change(element(view, "#name-form"), %{"identity" => %{"name" => name}})
  end

  defp submit_form(view) do
    render_submit(element(view, "#name-form"))
  end

  test "claims a new name, shows the access string, and starts a focused game", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    set_name(view, "alice-lobby")
    submit_form(view)

    assert has_element?(view, "#access-string")
    assert has_element?(view, "#access-string-value")

    render_click(element(view, "#start-button"))

    assert has_element?(view, "#focused-name", "alice-lobby")
    assert render(view) =~ ~r/value="alice-lobby"/
  end

  test "a taken name switches to the reclaim form, then reclaims with the access string", %{
    conn: conn
  } do
    {:ok, _player, secret} = Players.claim_name("bob-lobby")
    {:ok, view, _html} = live(conn, "/")

    set_name(view, "bob-lobby")
    submit_form(view)

    # Taken: the form offers the access string input.
    assert has_element?(view, "#lobby-access")
    assert has_element?(view, "#lobby-notice", ~r/taken/i)

    render_change(element(view, "#name-form"), %{"identity" => %{"access" => secret}})
    submit_form(view)

    assert has_element?(view, "#lobby-notice", ~r/reclaimed/i)
  end

  test "a wrong access string is rejected", %{conn: conn} do
    {:ok, _player, _secret} = Players.claim_name("carol-lobby")
    {:ok, view, _html} = live(conn, "/")

    set_name(view, "carol-lobby")
    submit_form(view)

    render_change(element(view, "#name-form"), %{
      "identity" => %{"access" => "WRONGACCESSSTRING00000"}
    })

    submit_form(view)

    assert has_element?(view, "#lobby-notice", ~r/does not match/i)
    refute has_element?(view, "#access-string")
  end

  test "a started game appears as a live card", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("dave-lobby")
    on_exit(fn -> Games.stop(player) end)

    {:ok, view, _html} = live(conn, "/")

    # start_game is synchronous: the initial lobby broadcast is already in
    # the view's mailbox, so the next render shows the card.
    Games.start_game(player, 42)
    assert has_element?(view, "#card-dave-lobby", "dave-lobby")
  end

  test "the focused surface reflects pushed game states", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    set_name(view, "erin-lobby")
    submit_form(view)
    render_click(element(view, "#start-button"))

    assert has_element?(view, "#focused-game")

    # Hard-drop a piece: its locked cells stay on the board, so poll the
    # focused board until a piece character (i/j/l/o/s/t/z) appears.
    player = Players.get_by_name("erin-lobby")
    Games.input(player, :hard)

    board =
      Enum.reduce_while(1..40, nil, fn _, _ ->
        Process.sleep(50)

        html = render(element(view, "#focused-board"))

        if String.match?(html, ~r/[ijklostz]/) do
          {:halt, html}
        else
          {:cont, nil}
        end
      end)

    assert board =~ ~r/[ijklostz]/
  end
end
