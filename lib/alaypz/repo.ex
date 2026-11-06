defmodule Alaypz.Repo do
  use Ecto.Repo,
    otp_app: :alaypz,
    adapter: Ecto.Adapters.SQLite3
end
