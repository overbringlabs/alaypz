defmodule AlaypzWeb.Markdown do
  @moduledoc """
  Markdown → HEEx via :mdex, for the static prose pages (/why,
  /the-case-for-and-against-local-ai).

  `document/1` returns an `MDEx.Document`; the caller renders it in a
  template with `MDEx.to_heex!/1`, so template assigns stay in the
  template.
  """

  # GFM table syntax — the chronicle's timeline is a pipe table.
  @gfm [extension: [table: true]]

  @doc "Parses `priv/<name>` as markdown (GFM tables enabled) and returns an `MDEx.Document`."
  def document(name) do
    path = Path.join(:code.priv_dir(:alaypz), name)
    MDEx.parse_document!(File.read!(path), @gfm)
  end
end
