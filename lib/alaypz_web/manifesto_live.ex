defmodule AlaypzWeb.ManifestoLive do
  @moduledoc """
  `/the-case-for-and-against-local-ai`: the local AI manifesto.

  A dead view on purpose — one static render, no events, no updates.
  The content is `priv/manifesto.md`, parsed by :mdex and styled by
  `.history-prose` (assets/css/app.css).
  """
  use AlaypzWeb, :live_view

  require MDEx

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "The case for and against local AI")
     |> assign(
       :og_description,
       "A rant, with the edge intact — the case for and against local AI."
     )}
  end
end
