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

  # The card of a late-mounted view arrives via lobby broadcasts the view
  # processes in real time; `render/1` flushes the pending diff to the DOM.
  defp await_card(view, attempts) do
    if attempts == 0 or has_element?(view, "#card-alice-spect") do
      :ok
    else
      Process.sleep(25)
      render(view)
      await_card(view, attempts - 1)
    end
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

  test "a fresh lobby shows the empty states", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert has_element?(view, "#games", "No games yet")
    assert has_element?(view, "#focused-section", "Start a game or click a card")
    assert has_element?(view, "#recent-results", "No finished games yet")
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

  test "a started game appears as a live card with its own canvas", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("dave-lobby")
    on_exit(fn -> Games.stop(player) end)

    {:ok, view, _html} = live(conn, "/")

    # start_game is synchronous: the initial lobby broadcast is already in
    # the view's mailbox, so the next render shows the card.
    Games.start_game(player, 42)
    assert has_element?(view, "#card-dave-lobby", "dave-lobby")
    assert has_element?(view, "#card-canvas-dave-lobby")
    assert has_element?(view, "#card-score-dave-lobby", "0")
  end

  test "clicking a card focuses the session; clicking it again unfocuses", %{
    conn: conn
  } do
    {:ok, player, _secret} = Players.claim_name("frank-lobby")
    on_exit(fn -> Games.stop(player) end)

    {:ok, view, _html} = live(conn, "/")
    Games.start_game(player, 7)

    render_click(element(view, "#card-frank-lobby"))
    assert has_element?(view, "#focused-name", "frank-lobby")
    assert has_element?(view, "#unfocus-button")

    render_click(element(view, "#card-frank-lobby"))
    assert has_element?(view, "#focused-section", "Start a game or click a card")
    refute has_element?(view, "#focused-game")
  end

  test "the unfocus button releases the session", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("grace-lobby")
    on_exit(fn -> Games.stop(player) end)

    {:ok, view, _html} = live(conn, "/")
    Games.start_game(player, 9)

    render_click(element(view, "#card-grace-lobby"))
    assert has_element?(view, "#focused-game")

    render_click(element(view, "#unfocus-button"))
    assert has_element?(view, "#focused-section", "Start a game or click a card")
    refute has_element?(view, "#focused-game")
  end

  test "the focused surface reflects pushed game states", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    set_name(view, "erin-lobby")
    submit_form(view)
    render_click(element(view, "#start-button"))

    assert has_element?(view, "#focused-game")
    assert has_element?(view, "#focused-canvas")

    # Hard-drop a piece: the locked cells stay on the board, and the score
    # goes above zero once the piece locks, so poll the scoreboard until it
    # is nonzero (the canvas itself is driven by a pushed event, not the DOM).
    # The view that started the game is the owner; re-attach this test
    # process so it can drive the game.
    player = Players.get_by_name("erin-lobby")
    Games.attach(player, self())
    Games.input(player, :hard)

    score =
      Enum.reduce_while(1..40, nil, fn _, _ ->
        Process.sleep(50)

        html = render(element(view, "#focused-score"))

        if String.match?(html, ~r/\d{2,}/) do
          {:halt, html}
        else
          {:cont, nil}
        end
      end)

    assert score =~ ~r/\d{2,}/
  end

  test "a spectator sees the spectating surface instead of the controls", %{conn: conn} do
    on_exit(fn ->
      for name <- ["alice-spect", "bob-spect"] do
        case Players.get_by_name(name) do
          nil -> :ok
          player -> Games.stop(player)
        end
      end
    end)

    # The owner: claims a name and starts the game (the view attaches itself).
    {:ok, owner_view, _html} = live(conn, "/")
    set_name(owner_view, "alice-spect")
    submit_form(owner_view)
    render_click(element(owner_view, "#start-button"))
    assert has_element?(owner_view, "#focused-game")
    refute has_element?(owner_view, "#focused-game", ~r/Spectating/i)

    # The spectator: claims its own name and focuses alice's card — the
    # surface renders in spectating mode (the key hook stays unmounted).
    # The card arrives via lobby broadcasts the view processes in real time.
    {:ok, spect_view, _html} = live(conn, "/")
    set_name(spect_view, "bob-spect")
    submit_form(spect_view)

    # Let the pending broadcasts land, then flush until the card renders.
    await_card(spect_view, 20)

    render_click(element(spect_view, "#card-alice-spect"))
    assert has_element?(spect_view, "#focused-game", ~r/Spectating/i)
  end

  test "the game-key event only acts on the view's own game" do
    {:ok, player, _secret} = Players.claim_name("dora-lobby")
    on_exit(fn -> Games.stop(player) end)
    Games.start_game(player, 42)
    Games.attach(player, self())
    Games.subscribe_game(player)

    # A view focused on dora's game but owning a different name: its key
    # events are skipped by the view gate (the piece keeps falling at x=3).
    spectator = %Phoenix.LiveView.Socket{
      assigns: %{
        form:
          Phoenix.Component.to_form(%{"name" => "victor-lobby", "access" => ""}, as: :identity),
        focused_name: "dora-lobby"
      }
    }

    {:noreply, _} =
      AlaypzWeb.LobbyLive.handle_event("game-key", %{"key" => "ArrowLeft"}, spectator)

    refute_receive %{type: :game, payload: %{piece: %{pos: {2, _y}}}}, 400

    # The owning view's key events pass the view gate and the process gate.
    owner = %Phoenix.LiveView.Socket{
      assigns: %{
        form: Phoenix.Component.to_form(%{"name" => "dora-lobby", "access" => ""}, as: :identity),
        focused_name: "dora-lobby"
      }
    }

    {:noreply, _} = AlaypzWeb.LobbyLive.handle_event("game-key", %{"key" => "ArrowLeft"}, owner)
    assert_receive %{type: :game, payload: %{piece: %{pos: {2, _y}}}}, 500
  end
end
