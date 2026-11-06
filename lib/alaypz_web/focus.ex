defmodule AlaypzWeb.Focus do
  @moduledoc """
  Subscribes the view to a player's game topic (`game:<name>`) for the
  the focused surface. Shared by the lobby (spectating) and the `/play` view.
  """
  import Phoenix.Component, only: [assign: 3]

  def focus_on(socket, name) do
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

  def unfocus_on(socket) do
    case socket.assigns.focused_name do
      nil ->
        socket

      old ->
        Phoenix.PubSub.unsubscribe(Alaypz.PubSub, "game:#{old}")
        assign(socket, :focused_name, nil)
    end
  end
end
