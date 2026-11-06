defmodule Alaypz.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AlaypzWeb.Telemetry,
      Alaypz.Repo,
      {Ecto.Migrator,
       repos: Application.fetch_env!(:alaypz, :ecto_repos), skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:alaypz, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Alaypz.PubSub},
      Alaypz.Games.Registry,
      {DynamicSupervisor, child_spec: :dynamic, name: Alaypz.Games.Supervisor},
      # Start a worker by calling: Alaypz.Worker.start_link(arg)
      # {Alaypz.Worker, arg},
      # Start to serve requests, typically the last entry
      AlaypzWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Alaypz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AlaypzWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") == nil
  end
end
