defmodule Doreiclient.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  # import Supervisor.Spec

  def start(_type, _args) do
    # import Supervisor.Spec
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Doreiclient.Repo,
      # Start the endpoint when the application starts
      DoreiclientWeb.Endpoint,
      # Starts a worker by calling: Doreiclient.Worker.start_link(arg)
      # {Doreiclient.Worker, arg},
      Guardian.DB.Token.SweeperServer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Doreiclient.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DoreiclientWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
