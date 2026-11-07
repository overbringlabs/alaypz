defmodule AlaypzWeb.HistoryLive do
  @moduledoc """
  `/history`: the development chronicle.

  A dead view on purpose — one static render, no events, no updates.
  The content is `priv/history.md`, parsed by :mdex and styled by
  `.history-prose` (assets/css/app.css).
  """
  use AlaypzWeb, :live_view

  require MDEx

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
