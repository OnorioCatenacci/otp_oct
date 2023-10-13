defmodule Lingo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Lingo.Worker.start_link(arg)
      # {Lingo.Worker, arg}
      # {Lingo.Server, :static_shock},
      # {Lingo.Server, :ironman},
      # {Lingo.Server, :groot}
      {DynamicSupervisor, name: :dynamic_sup, strategy: :one_for_one}
      #
      # {:ok, counter1} =
      # DynamicSupervisor.start_child(MyApp.DynamicSupervisor, {Counter, 0})
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: :main_sup]
    Supervisor.start_link(children, opts)
  end
end
