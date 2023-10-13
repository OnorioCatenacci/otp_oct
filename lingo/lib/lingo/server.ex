defmodule Lingo.Server do
  use GenServer
  alias Lingo.Game

  #Server
  @impl true
  def init(_) do
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



  #Client

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def show(name) do
    IO.puts(GenServer.call(name, :show))
  end

  def move(name, guess) do
    GenServer.cast(name, {:move, guess})
  end

  def boom(name) do
    GenServer.cast(name, :boom)
  end




end
