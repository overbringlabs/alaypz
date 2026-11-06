defmodule AlaypzWeb.ControlsLegend do
  @moduledoc """
  The key hints for playing a focused game — a compact `kbd`-chip strip for
  headers (`compact/1`) and a labeled list for the session panel (`rows/1`).
  """
  use Phoenix.Component

  @actions [
    %{keys: ["←", "→"], label: "move"},
    %{keys: ["↓"], label: "soft drop"},
    %{keys: ["↑"], label: "hard drop"},
    %{keys: ["Z", "X"], label: "rotate"},
    %{keys: ["C"], label: "hold"}
  ]

  attr :class, :string, default: ""

  # One horizontal strip: [kbd kbd] label [kbd kbd] label …
  def compact(assigns) do
    assigns =
      assigns
      |> Map.put_new(:class, "")
      |> assign_new(:actions, fn -> @actions end)

    ~H"""
    <span class={[@class, "inline-flex flex-wrap items-center gap-x-4 gap-y-1"]}>
      <span :for={action <- @actions} class="inline-flex items-center gap-1.5">
        <span :for={key <- action.keys} class="kbd">{key}</span>
        <span class="text-xs text-base-content/60">{action.label}</span>
      </span>
    </span>
    """
  end

  # Labeled rows: the kbd chips right-aligned next to each action name.
  def rows(assigns) do
    assigns =
      assigns
      |> Map.put_new(:class, "")
      |> assign_new(:actions, fn -> @actions end)

    ~H"""
    <span class={[@class, "flex flex-col gap-2.5"]}>
      <span :for={action <- @actions} class="flex items-center gap-3">
        <span class="flex w-16 justify-end gap-1">
          <span :for={key <- action.keys} class="kbd">{key}</span>
        </span>
        <span class="text-sm text-base-content/70">{action.label}</span>
      </span>
    </span>
    """
  end
end
