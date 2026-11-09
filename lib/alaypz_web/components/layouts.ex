defmodule AlaypzWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use AlaypzWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://phoenix.hexdocs.pm/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <header
      id="app-header"
      class="sticky top-0 z-10 border-b border-base-300/60 bg-base-100/85 backdrop-blur"
    >
      <div class="mx-auto flex max-w-6xl flex-wrap items-center gap-x-6 gap-y-2 px-4 py-3">
        <a href="/" class="extromino-wordmark text-xl font-black tracking-[0.3em]">
          ALAYPZ
        </a>
        <span class="hidden text-xs text-base-content/60 lg:inline">live boards</span>
        <nav class="ml-auto flex items-center gap-4 text-sm font-semibold">
          <a
            href="/"
            class="rounded px-0.5 text-base-content/70 transition hover:text-cyan-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/50"
          >
            Lobby
          </a>
          <a
            href="/leaderboard"
            class="rounded px-0.5 text-base-content/70 transition hover:text-cyan-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/50"
          >
            Leaderboard
          </a>
          <a
            href="https://github.com/overbringlabs/alaypz"
            target="_blank"
            rel="noopener"
            class="rounded px-0.5 text-base-content/70 transition hover:text-cyan-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/50"
          >
            Source
          </a>
        </nav>
        <.theme_toggle />
      </div>
    </header>

    <main class="px-4 py-8 sm:px-6">
      <div class="mx-auto max-w-6xl">
        {render_slot(@inner_block)}
      </div>
    </main>

    <%!-- marketing footer: the Overbring logo links home; the app itself
         is the demonstration --%>
    <footer
      id="site-footer"
      class="border-t border-base-300/60"
    >
      <div class="mx-auto flex max-w-6xl flex-wrap items-center justify-between gap-x-8 gap-y-4 px-4 py-6 sm:px-6">
        <a
          href="https://overbring.com"
          target="_blank"
          rel="noopener"
          class="flex items-center rounded transition hover:opacity-75 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/50"
        >
          <img
            src="/images/overbring.webp"
            alt="OVERBRING Labs"
            class="h-6 w-auto dark:invert dark:brightness-0"
          />
        </a>
        <p class="text-xs leading-relaxed text-base-content/50">
          a local-AI experiment — built with Qwen3.8-27B ·
          <a
            href="/why"
            class="underline decoration-base-300 underline-offset-2 transition hover:text-cyan-500"
          >
            Why does this exist?
          </a>
          ·
          <a
            href="https://overbring.com/articles/2026-11-09-the-case-for-and-against-local-personal-ai/"
            class="underline decoration-base-300 underline-offset-2 transition hover:text-cyan-500"
          >
            The case for and against local, personal AI
          </a>
          ·
          <a
            href="https://github.com/overbringlabs/alaypz"
            target="_blank"
            rel="noopener"
            class="underline decoration-base-300 underline-offset-2 transition hover:text-cyan-500"
          >
            Source
          </a>
        </p>
      </div>
    </footer>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={
          show(".phx-client-error #client-error")
          |> JS.remove_attribute("hidden", to: ".phx-client-error #client-error")
        }
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={
          show(".phx-server-error #server-error")
          |> JS.remove_attribute("hidden", to: ".phx-server-error #server-error")
        }
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Theme toggle for the daisyUI system/light/dark themes.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 [[data-theme-source=system]_&]:!left-0 transition-[left]" />

      <button
        class="flex w-1/3 cursor-pointer rounded-full p-2 transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/70"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex w-1/3 cursor-pointer p-2 transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/70"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex w-1/3 cursor-pointer p-2 transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/70"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end
end
