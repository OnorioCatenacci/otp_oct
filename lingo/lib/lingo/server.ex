defmodule Lingo.Server do
  use GenServer
  alias Lingo.Game

  # Server
  # @impl true
  def init(name) do
    IO.puts("starting game with name #{name}")
    {:ok, Lingo.Game.new()}
  end

  @impl true
  def handle_cast({:move, guess}, game) do
    {:noreply, Game.move(game, guess)}
  end

  @impl true
  def handle_cast(:boom, _) do
    raise "boom"
  end

  @impl true
  def handle_call(:show, _from, game) do
    {:reply, Game.show(game), game}
  end

  # Client
  def child_spec(name) do
    %{id: name, start: {Lingo.Server, :start_link, [name]}}
  end

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def show(name) do
    IO.puts(GenServer.call(name, :show))
  end

  def move(name, guess) do
    GenServer.cast(name, {:move, guess})
    show(name)
  end

  def boom(name) do
    GenServer.cast(name, :boom)
  end
end
