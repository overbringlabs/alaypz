defmodule AlaypzWeb.StatusChip do
  @moduledoc """
  A small coloured pill for a game's state — used by the lobby cards and the
  focused session panel.
  """
  use Phoenix.Component

  attr :status, :any, required: true
  attr :reconnecting, :boolean, default: false
  attr :class, :string, default: ""

  def chip(assigns) do
    assigns = Map.put_new(assigns, :class, "")

    {kind, label} =
      cond do
        assigns.status == nil ->
          {:stopped, "stopped"}

        assigns.reconnecting and assigns.status == :playing ->
          {:warning, "reconnecting"}

        assigns.status == :finished ->
          {:done, "finished"}

        assigns.status == :interrupted ->
          {:interrupted, "interrupted"}

        true ->
          {:live, "live"}
      end

    assigns
    |> assign(:kind, kind)
    |> assign(:label, label)
    |> chip_render()
  end

  defp chip_render(assigns) do
    ~H"""
    <span class={[
      @class,
      "inline-flex items-center gap-1.5 rounded-full border px-2 py-0.5 text-[0.6875rem] font-semibold uppercase tracking-wider",
      @kind == :live && "border-cyan-400/40 bg-cyan-400/10 text-cyan-700 dark:text-cyan-300",
      @kind == :warning && "border-amber-400/40 bg-amber-400/10 text-amber-700 dark:text-amber-300",
      @kind == :done && "border-violet-400/40 bg-violet-400/10 text-violet-700 dark:text-violet-300",
      @kind == :interrupted && "border-rose-400/40 bg-rose-400/10 text-rose-700 dark:text-rose-300",
      @kind == :stopped && "border-base-300 bg-base-200 text-base-content/60"
    ]}>
      <span class={[
        "h-1.5 w-1.5 rounded-full",
        @kind == :live && "animate-pulse bg-cyan-500 dark:bg-cyan-300",
        @kind == :warning && "bg-amber-500 dark:bg-amber-300",
        @kind == :done && "bg-violet-500 dark:bg-violet-300",
        @kind == :interrupted && "bg-rose-500 dark:bg-rose-300",
        @kind == :stopped && "bg-base-content/40"
      ]} />
      {@label}
    </span>
    """
  end
end
