defmodule AlaypzWeb.IdentityForm do
  @moduledoc """
  The name-claim form shared by the lobby and the `/play` view: name input
  (auto-filled from `localStorage.alaypz_name` via the `.LocalName` hook),
  optional access-string input in reclaim mode, the claim button, an optional
  Start/Play button, the one-time access-string box, and the notice line.

  The parent view handles the `validate` and `submit` events and passes
  through its `:form`/`:mode`/`:access_string`/`:notice` assigns. `:input_prefix`
  keeps the name/access input ids unique per page (`#lobby-name` vs
  `#play-name`).
  """
  use Phoenix.Component

  import AlaypzWeb.CoreComponents, only: [input: 1]

  attr :form, :map, required: true
  attr :mode, :atom, default: :claim
  attr :access_string, :any, default: nil
  attr :notice, :any, default: nil
  attr :input_prefix, :string, required: true
  attr :start_label, :string, default: "Start game"
  attr :start_action, :string, default: "start"

  # The "Claim your name" heading level: 1 on /play (the form is the page's
  # primary content), 2 on the lobby (the page h1 is the hero title).
  attr :title_level, :integer, default: 1

  def identity_form(assigns) do
    ~H"""
    <section id="identity" class="rounded-xl border border-base-300/60 bg-base-100 p-4 shadow-sm">
      <div class="mb-3 flex flex-wrap items-baseline justify-between gap-3">
        <%= if @title_level == 1 do %>
          <h1 class="font-display text-lg font-bold text-base-content">Claim your name</h1>
        <% else %>
          <h2 class="font-display text-lg font-bold text-base-content">Claim your name</h2>
        <% end %>
        <span class="text-xs text-base-content/60">
          your name is stored in this browser — the access string reclaims it elsewhere
        </span>
      </div>

      <.form for={@form} id="name-form" phx-change="validate" phx-submit="submit">
        <div class="flex flex-wrap items-center gap-2">
          <.input
            field={@form[:name]}
            type="text"
            placeholder="Your name"
            id={"#{@input_prefix}-name"}
            class="w-56 input text-base"
            phx-hook="LocalName"
          />

          <%= if @mode == :reclaim do %>
            <.input
              field={@form[:access]}
              type="text"
              placeholder="Access string"
              id={"#{@input_prefix}-access"}
              class="w-64 input text-base"
            />
          <% end %>

          <button
            type="submit"
            id="claim-button"
            class="cursor-pointer rounded-lg bg-cyan-600 px-4 py-2 text-sm font-semibold text-white transition hover:bg-cyan-500 hover:shadow-[0_0_20px_rgba(0,229,255,0.35)] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyan-400/70"
          >
            {if @mode == :reclaim, do: "Reclaim name", else: "Claim name"}
          </button>

          <button
            type="button"
            id="start-button"
            phx-click={@start_action}
            phx-value-name={@form[:name].value || ""}
            class="cursor-pointer rounded-lg bg-emerald-600 px-4 py-2 text-sm font-semibold text-white transition hover:bg-emerald-500 hover:shadow-[0_0_20px_rgba(52,211,153,0.35)] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-400/70 disabled:cursor-not-allowed disabled:opacity-40"
            disabled={@form[:name].value in [nil, ""]}
          >
            {@start_label}
          </button>
        </div>

        <%= for {field, {message, _opts}} <- @form.errors do %>
          <p id={"form-error-#{field}"} class="mt-2 text-sm text-rose-400">{message}</p>
        <% end %>
      </.form>

      <%= if @access_string do %>
        <div
          id="access-string"
          class="mt-3 rounded-lg border border-amber-500/40 bg-amber-500/10 p-3"
        >
          <p class="text-sm font-semibold text-amber-600 dark:text-amber-300">
            Access string — shown only once. Keep it to reclaim this name later:
          </p>
          <p
            id="access-string-value"
            class="mt-1 break-words text-lg font-semibold tracking-widest text-amber-600 dark:text-amber-200"
          >
            {@access_string}
          </p>
        </div>
      <% end %>

      <%= if @notice do %>
        <p id="lobby-notice" class="mt-3 text-sm text-base-content/80">{@notice}</p>
      <% end %>
    </section>
    """
  end
end
