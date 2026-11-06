defmodule Alaypz.Games.Registry do
  @moduledoc "One entry per running game (player id -> game process)."

  def start_link(opts \\ []) do
    Registry.start_link([name: __MODULE__, keys: :unique] ++ opts)
  end

  def child_spec(opts) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [opts]}, type: :worker}
  end
end
