defmodule Toilets.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ToiletsWeb.Telemetry,
      Toilets.Repo,
      {DNSCluster, query: Application.get_env(:toilets, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Toilets.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Toilets.Finch},
      # Start a worker by calling: Toilets.Worker.start_link(arg)
      # {Toilets.Worker, arg},
      # Start to serve requests, typically the last entry
      ToiletsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Toilets.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ToiletsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
