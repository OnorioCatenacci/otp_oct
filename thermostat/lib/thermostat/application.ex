defmodule Thermostat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Thermostat.Worker.start_link(arg)
      {Thermostat.Server, :one},
      {Thermostat.Server, :two},
      {Thermostat.Server, :three},
      {Thermostat.Server, :four}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: :sup]
    Supervisor.start_link(children, opts)
  end
end
