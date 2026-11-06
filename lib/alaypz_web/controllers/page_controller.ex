defmodule AlaypzWeb.PageController do
  use AlaypzWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
