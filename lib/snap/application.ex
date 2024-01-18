defmodule Snap.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SnapWeb.Telemetry,
      Snap.Repo,
      {DNSCluster, query: Application.get_env(:snap, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Snap.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Snap.Finch},
      # Start a worker by calling: Snap.Worker.start_link(arg)
      # {Snap.Worker, arg},
      # Start to serve requests, typically the last entry
      SnapWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Snap.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SnapWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
