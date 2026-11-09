defmodule AlaypzWeb.OG do
  @moduledoc """
  Per-request OpenGraph data for the root layout.

  `og:url` and `og:image` must be absolute. In prod the canonical public
  URL (`config :alaypz, :og, canonical:` — the deployment is reverse
  proxied by Caddy, so the app's own host/port is internal) wins; in
  dev/test the URL is derived from the request, so link previews work
  on whatever host the app is served on.
  The plug assigns `:og`; the root layout renders the meta tags.
  Per-page `og:title` / `og:description` come from the `:page_title` /
  `:og_description` assigns, falling back to the `config :alaypz, :og`
  defaults.
  """
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    cfg = config()
    base = cfg[:canonical] || request_base(conn)
    path = if conn.path_info in [nil, []], do: "", else: "/" <> Enum.join(conn.path_info, "/")

    assign(conn, :og, %{
      url: base <> path,
      image: base <> cfg[:image_path],
      image_alt: cfg[:image_alt],
      image_width: cfg[:image_width],
      image_height: cfg[:image_height]
    })
  end

  @doc "The `config :alaypz, :og` defaults (title, site_name, description, image)."
  def config, do: Application.get_env(:alaypz, :og)

  defp request_base(conn) do
    scheme = conn.scheme || :http
    host = conn.host || "localhost"
    # Omit well-known ports, like a browser's location bar does.
    host_part = if conn.port in [80, 443], do: host, else: "#{host}:#{conn.port}"
    "#{scheme}://#{host_part}"
  end
end
