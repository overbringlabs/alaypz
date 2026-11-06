defmodule AlaypzWeb.LobbyLive do
  @moduledoc """
  The lobby: claim or reclaim a name, watch every live game on its live card,
  focus another player's session to spectate it, and open a top result's
  session drawer.

  Playing happens on `/play` — the owner's play session (keyboard and
  on-screen controls) only exists there. The focused section here is a
  spectating surface for other players' games; the Play button and your own
  card navigate to `/play` instead of focusing in place.
  """
  use AlaypzWeb, :live_view

  alias Alaypz.Scores
  alias AlaypzWeb.FocusedGame
  alias AlaypzWeb.Focus
  alias AlaypzWeb.GameCard
  alias AlaypzWeb.Identity

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Alaypz.PubSub, "lobby")
    end

    {:ok,
     socket
     |> assign(:form, to_form(%{"name" => "", "access" => ""}, as: :identity))
     |> assign(:mode, :claim)
     |> assign(:access_string, nil)
     |> assign(:notice, nil)
     |> assign(:cards, [])
     |> assign(:focused_name, nil)
     |> assign(:session, nil)
     |> assign(:session_rank, nil)
     |> assign(:results, Scores.list_top(5))}
  end

  # Track the form state so `phx-value-*` attributes stay in sync with the
  # inputs (submit events carry the DOM values; this keeps the server copy).
  @impl true
  def handle_event("validate", %{"identity" => form}, socket) do
    {:noreply, assign(socket, form: to_form(form, as: :identity))}
  end

  # The name form: submit without an access string claims the name; with an
  # access string it reclaims a taken one.
  @impl true
  def handle_event("submit", %{"identity" => %{"name" => name} = params}, socket) do
    access = params["access"] || ""

    {_outcome, socket} =
      if access == "" do
        Identity.claim(name, socket)
      else
        Identity.reclaim(name, access, socket)
      end

    {:noreply, socket}
  end

  # The play session (and its controls) live on /play; this is the entry
  # point to it.
  @impl true
  def handle_event("start", _params, socket) do
    {:noreply, push_navigate(socket, to: "/play")}
  end

  # Clicking a card focuses the session on it (spectating); clicking the
  # focused card (or the Unfocus button) releases it. Clicking your *own*
  # card goes to /play — the play session only happens there.
  @impl true
  def handle_event("focus", %{"name" => name}, socket) do
    own = socket.assigns.form[:name].value

    socket =
      cond do
        own && String.downcase(name) == String.downcase(own) ->
          push_navigate(socket, to: "/play")

        socket.assigns.focused_name == name ->
          Focus.unfocus_on(socket)

        true ->
          Focus.focus_on(socket, name)
      end

    {:noreply, socket}
  end

  @impl true
  def handle_event("unfocus", _, socket) do
    {:noreply, Focus.unfocus_on(socket)}
  end

  # Open the session drawer for a top-result card.
  @impl true
  def handle_event("open-session", %{"id" => id}, socket) do
    # Client-controlled param: parse, don't raise.
    case Integer.parse(id) do
      {n, _} ->
        id = n
        rank = Enum.find_index(socket.assigns.results, &(&1.id == id))
        score = Enum.find(socket.assigns.results, &(&1.id == id))
        {:noreply, assign(socket, session: score, session_rank: rank)}

      :error ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_event("close-session", _, socket) do
    {:noreply, assign(socket, session: nil, session_rank: nil)}
  end

  # Live cards: every game change broadcasts its summary and full payload
  # here, so each card can keep its mini-canvas up to date.
  @impl true
  def handle_info(%{type: :lobby, name: name} = msg, socket) do
    socket =
      if name in socket.assigns.cards do
        send_update(
          GameCard,
          id: name,
          payload: msg[:payload],
          status: msg[:status],
          reconnecting: Map.get(msg, :reconnecting, false)
        )

        socket
      else
        assign(socket, :cards, socket.assigns.cards ++ [name])
      end

    # A game ended: refresh the top results.
    socket =
      if msg[:status] in [:finished, :interrupted] do
        assign(socket, :results, Scores.list_top(5))
      else
        socket
      end

    {:noreply, socket}
  end

  # The focused game's topic: push every engine state to the surface.
  @impl true
  def handle_info(%{type: :game, status: status, payload: payload}, socket) do
    if socket.assigns.focused_name do
      send_update(FocusedGame, id: :focused, payload: payload, status: status)
    end

    {:noreply, socket}
  end
end
