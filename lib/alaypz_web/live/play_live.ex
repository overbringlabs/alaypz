defmodule AlaypzWeb.PlayLive do
  @moduledoc """
  `/play`: the play session for the claimed name. Starting the game, driving
  it (keyboard + swipe gestures via `.AlaypzKeys` — the board itself is the
  touch surface on mobile), and watching your own board all happen here —
  the lobby is a spectating surface and sends play to this route.

  The view attaches to its own game as owner (`Games.attach`); the game
  process repeats the owner check against the caller pid, so inputs from a
  view whose claimed name does not match the focused game are dropped twice.
  """
  use AlaypzWeb, :live_view

  alias Alaypz.Games
  alias Alaypz.Players
  alias AlaypzWeb.FocusedGame
  alias AlaypzWeb.Focus
  alias AlaypzWeb.Identity

  # The `.AlaypzKeys` hook: arrow/letter keys act on the focused game.
  @key_actions %{
    "ArrowLeft" => :left,
    "ArrowRight" => :right,
    "ArrowDown" => :soft,
    "ArrowUp" => :hard,
    "z" => :ccw,
    "Z" => :ccw,
    "x" => :cw,
    "X" => :cw,
    "c" => :hold,
    "C" => :hold
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:form, to_form(%{"name" => "", "access" => ""}, as: :identity))
     |> assign(:mode, :claim)
     |> assign(:access_string, nil)
     |> assign(:notice, nil)
     |> assign(:focused_name, nil)
     |> assign(:game_status, nil)}
  end

  # Track the form state so `phx-value-*` attributes stay in sync with the
  # inputs (submit events carry the DOM values; this keeps the server copy).
  @impl true
  def handle_event("validate", %{"identity" => form}, socket) do
    {:noreply, assign(socket, form: to_form(form, as: :identity))}
  end

  # The name form: submit without an access string claims the name; with an
  # access string it reclaims a taken one. When a game is already running
  # for the (re)claimed name — e.g. a reload mid-game — re-attach as owner
  # and bring the surface back up.
  @impl true
  def handle_event("submit", %{"identity" => %{"name" => name} = params}, socket) do
    access = params["access"] || ""

    {outcome, socket} =
      if access == "" do
        Identity.claim(name, socket)
      else
        Identity.reclaim(name, access, socket)
      end

    # `:taken` means the name is already claimed (typically by this browser
    # before a reload): a running game for it gets re-attached instead of
    # left orphaned. `:invalid`/`:mismatch` do not.
    socket =
      if outcome in [:ok, :taken] do
        socket = maybe_attach(socket)

        # The name is already claimed and the surface came up: that is
        # usually this browser's own saved name — drop the reclaim-mode
        # ceremony (access input + notice) for it.
        if outcome == :taken and socket.assigns.focused_name do
          socket |> assign(:mode, :claim) |> assign(:notice, nil)
        else
          socket
        end
      else
        socket
      end

    {:noreply, socket}
  end

  # Start (or restart) the game for the claimed name, attach the view as
  # owner, and bring up the play surface.
  @impl true
  def handle_event("start", %{"name" => name}, socket) do
    socket =
      case Identity.resolve_or_claim(name) do
        {:ok, player, secret} ->
          {:ok, _pid} = Games.start_game(player, System.unique_integer([:positive]))
          Games.attach(player, self())

          socket
          |> assign(:access_string, secret || nil)
          |> assign(:notice, nil)
          |> assign(:game_status, nil)
          |> Focus.focus_on(player.name)

        {:error, changeset} ->
          message = Identity.name_error_message(changeset) || "Could not claim that name."
          assign(socket, :notice, message)
      end

    {:noreply, socket}
  end

  # The `.AlaypzKeys` hook: keys act on the view's own game only.
  @impl true
  def handle_event("game-key", %{"key" => key}, socket) do
    own_game_input(socket, Map.get(@key_actions, key))
    {:noreply, socket}
  end

  # The `#unfocus-button` inside the focused surface.
  @impl true
  def handle_event("unfocus", _, socket) do
    {:noreply, Focus.unfocus_on(socket)}
  end

  # The focused game's topic: push every engine state to the surface.
  @impl true
  def handle_info(%{type: :game, status: status, payload: payload}, socket) do
    socket =
      if socket.assigns.focused_name do
        send_update(FocusedGame, id: :focused, payload: payload, status: status)
        assign(socket, :game_status, status)
      else
        socket
      end

    {:noreply, socket}
  end

  # --- internals ---------------------------------------------------------

  # Terminal states: on the game screen the claim form (Start = restart)
  # comes back so a finished/interrupted game has a way forward.
  defp game_over?(status), do: status in [:finished, :interrupted]

  # Inputs only reach the view's own game; the game process enforces the
  # same owner gate against the caller pid.
  defp own_game_input(_socket, nil), do: :ok

  defp own_game_input(socket, action) do
    name = socket.assigns.focused_name
    own = socket.assigns.form[:name].value

    if name && own && String.downcase(name) == String.downcase(own) do
      case Players.get_by_name(name) do
        nil -> :ok
        player -> Games.input(player, action)
      end
    end

    :ok
  end

  # Re-attach when a game is already running for the (re)claimed name — e.g.
  # reloading /play mid-game. Claiming a fresh name has no game yet.
  defp maybe_attach(socket) do
    case Players.get_by_name(socket.assigns.form[:name].value) do
      player when is_struct(player, Players.Player) ->
        case Games.state(player) do
          nil ->
            socket

          state ->
            # A finished/interrupted game still has a state — attach to it
            # and surface the status so the claim form (Start = restart)
            # comes back on the game screen.
            Games.attach(player, self())

            socket
            |> Focus.focus_on(player.name)
            |> assign(:game_status, state.status)
        end

      _ ->
        socket
    end
  end
end
