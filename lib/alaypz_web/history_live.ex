defmodule AlaypzWeb.HistoryLive do
  @moduledoc """
  `/why`: why this exists — the rebuttal, and how this one was built.

  A dead view on purpose — one static render, no events, no updates.
  The content is `priv/history.md`, parsed by :mdex and styled by
  `.history-prose` (assets/css/app.css).
  """
  use AlaypzWeb, :live_view

  require MDEx

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Why does this exist?")
     |> assign(
       :og_description,
       "Why Alaypz exists — the rebuttal, and how this one was built."
     )}
  end
end
