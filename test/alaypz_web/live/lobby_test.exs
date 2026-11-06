defmodule AlaypzWeb.LobbyLiveTest do
  use AlaypzWeb.ConnCase

  require Phoenix.ConnTest
  import Phoenix.LiveViewTest

  alias Alaypz.Games
  alias Alaypz.Players
  alias Alaypz.Scores

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

  test "claims a new name, shows the access string, and Play goes to /play", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    set_name(view, "alice-lobby")
    submit_form(view)

    assert has_element?(view, "#access-string")
    assert has_element?(view, "#access-string-value")
    assert render(view) =~ ~r/value="alice-lobby"/

    # The play session only happens on /play; the button is the entry point
    # (the test client reports the pushed navigate as a live_redirect).
    assert {:error, {:live_redirect, %{to: "/play"}}} =
             render_click(element(view, "#start-button"))
  end

  test "a fresh lobby shows the empty states", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert has_element?(view, "#games", "No games yet")
    assert has_element?(view, "#focused-section", "Start a game or click a card")
    assert has_element?(view, "#recent-results", "No finished games yet")
  end

  defp top_row_board, do: List.duplicate(List.duplicate(nil, 10), 20)

  defp record(player, score) do
    Scores.record(%{
      player_id: player.id,
      score: score,
      lines: 1,
      level: 1,
      end_reason: "finished",
      board: Scores.encode_board(top_row_board())
    })
  end

  test "top results are listed by score desc and open the session drawer", %{conn: conn} do
    {:ok, p1, _secret} = Players.claim_name("top-one")
    {:ok, p2, _secret} = Players.claim_name("top-two")
    {:ok, low} = record(p1, 50)
    {:ok, high} = record(p2, 900)

    {:ok, view, _html} = live(conn, "/")

    # Score desc: the 900 card precedes the 50 card.
    html = render(view)
    {high_pos, _size} = :binary.match(html, "result-#{high.id}")
    {low_pos, _size} = :binary.match(html, "result-#{low.id}")
    assert high_pos < low_pos

    render_click(element(view, "#result-#{high.id}"))
    assert has_element?(view, "#session-drawer", "top-two")

    render_click(element(view, "#session-close"))
    refute has_element?(view, "#session-drawer")
  end

  test "a non-numeric id from a tampered client is ignored, not a crash", %{conn: conn} do
    socket = %Phoenix.LiveView.Socket{
      assigns: %{results: [], session: nil, session_rank: nil}
    }

    {:noreply, socket} =
      AlaypzWeb.LobbyLive.handle_event("open-session", %{"id" => "garbage"}, socket)

    assert socket.assigns.session == nil
    assert socket.assigns.session_rank == nil
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

  test "clicking your own card navigates to /play", %{conn: conn} do
    {:ok, player, _secret} = Players.claim_name("erin-lobby")
    on_exit(fn -> Games.stop(player) end)

    {:ok, view, _html} = live(conn, "/")
    Games.start_game(player, 11)

    set_name(view, "erin-lobby")
    submit_form(view)

    assert has_element?(view, "#card-erin-lobby")
    assert {:error, {:live_redirect, %{to: "/play"}}} =
             render_click(element(view, "#card-erin-lobby"))
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

    # The owner's game runs (their play session lives on /play); the lobby
    # card is what a spectator can focus here.
    {:ok, owner_player, _secret} = Players.claim_name("alice-spect")
    Games.start_game(owner_player, 3)

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
end
