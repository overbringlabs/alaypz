defmodule AlaypzWeb.LobbyLive do
  @moduledoc """
  The lobby at `/`.

  Name flow (D-20261106-02): the form claims a name (the one-time access
  string is shown exactly once) or, for a taken name, reclaims it with the
  access string. Starting a game resolves (claiming if needed), starts the
  server-authoritative game process, attaches the view as owner, and focuses
  the game surface on it.

  Live cards: components cannot subscribe to PubSub, so the view subscribes
  to the `"lobby"` topic and `send_update`s each `GameCard`. The focused
  game surface is a `FocusedGame` component fed from the focused game's
  `game:<name>` topic.
  """
  use AlaypzWeb, :live_view

  alias Alaypz.Games
  alias Alaypz.Players
  alias Alaypz.Scores
  alias AlaypzWeb.FocusedGame
  alias AlaypzWeb.GameCard

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
     |> assign(:results, Scores.list_recent(5))}
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

    socket =
      if access == "" do
        claim(name, socket)
      else
        reclaim(name, access, socket)
      end

    {:noreply, socket}
  end

  # Start (or restart) the game for a name, attach the view as owner, and
  # focus the game surface on it.
  @impl true
  def handle_event("start", %{"name" => name}, socket) do
    socket =
      case resolve_or_claim(name) do
        {:ok, player, secret} ->
          {:ok, _pid} = Games.start_game(player, System.unique_integer([:positive]))
          Games.attach(player, self())

          socket
          |> assign(:access_string, secret || nil)
          |> assign(:notice, nil)
          |> focus_on(player.name)

        {:error, changeset} ->
          message = name_error_message(changeset) || "Could not claim that name."
          assign(socket, :notice, message)
      end

    {:noreply, socket}
  end

  # Clicking a card focuses the game surface on it.
  @impl true
  def handle_event("focus", %{"name" => name}, socket) do
    {:noreply, focus_on(socket, name)}
  end

  # Live cards: every game change broadcasts a summary here.
  @impl true
  def handle_info(%{type: :lobby, name: name} = msg, socket) do
    socket =
      if name in socket.assigns.cards do
        send_update(
          GameCard,
          id: name,
          score: msg[:score],
          status: msg[:status],
          reconnecting: Map.get(msg, :reconnecting, false)
        )

        socket
      else
        assign(socket, :cards, socket.assigns.cards ++ [name])
      end

    # A game ended: refresh the recent results.
    socket =
      if msg[:status] in [:finished, :interrupted] do
        assign(socket, :results, Scores.list_recent(5))
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

  # --- internals ---------------------------------------------------------

  defp claim(name, socket) do
    case Players.claim_name(name) do
      {:ok, player, secret} ->
        socket
        |> assign(:access_string, secret)
        |> assign(:mode, :claim)
        |> assign(:notice, "Name claimed. Keep the access string — it is shown only once.")
        |> put_name(player.name)

      {:error, changeset} ->
        # A taken name switches the form into reclaim mode; anything else is
        # a plain validation error. changeset.errors is a keyword list.
        if Keyword.get(changeset.errors, :name) do
          socket
          |> assign(:mode, :reclaim)
          |> assign(:notice, "That name is taken. Submit its access string to reclaim it.")
          |> put_name(name)
        else
          assign(socket, form: to_form(changeset, as: :identity))
        end
    end
  end

  defp reclaim(name, access, socket) do
    case Players.reclaim_name(name, access) do
      {:ok, player} ->
        socket
        |> assign(:mode, :claim)
        |> assign(:notice, "Name reclaimed.")
        |> put_name(player.name)

      # The name is unknown, i.e. free: claim it instead.
      {:error, :name_not_found} ->
        claim(name, socket)

      {:error, :secret_mismatch} ->
        assign(
          socket,
          :notice,
          "Access string does not match. Try again, or reclaim a different way."
        )
    end
  end

  defp put_name(socket, name) do
    assign(socket, form: to_form(%{"name" => name, "access" => ""}, as: :identity))
  end

  # `start` needs the player: use the existing one, or claim it fresh.
  defp resolve_or_claim(name) do
    case Players.get_by_name(name) do
      nil ->
        case Players.claim_name(name) do
          {:ok, player, secret} -> {:ok, player, secret}
          {:error, changeset} -> {:error, changeset}
        end

      player ->
        {:ok, player, nil}
    end
  end

  defp name_error_message(changeset) do
    changeset.errors
    |> Keyword.get(:name)
    |> then(fn
      {message, _opts} -> message
      _ -> nil
    end)
  end

  defp focus_on(socket, name) do
    case socket.assigns.focused_name do
      nil ->
        :ok

      old ->
        Phoenix.PubSub.unsubscribe(Alaypz.PubSub, "game:#{old}")
    end

    Phoenix.PubSub.subscribe(Alaypz.PubSub, "game:#{name}")

    # The surface component self-hydrates on (re)mount for the new name;
    # further states arrive via the game topic.
    assign(socket, :focused_name, name)
  end
end
