defmodule Thermostat.Server do
  use GenServer

  alias Thermostat.Counter
  # Client
  def start_link(input) do
    GenServer.start_link(__MODULE__, input, name: :counter)
  end

  def show do
    GenServer.call(:counter, :show)
  end

  def inc do
    GenServer.cast(:counter, :inc)
  end

  def dec do
    GenServer.cast(:counter, :dec)
  end

  # Count Server
  @impl true
  def init(input) do
    IO.puts("We got to the init with #{input}")
    state = Counter.new(input)
    {:ok, state}
  end

  @impl true
  def handle_call(:show, _from, counter) do
    {:reply, Counter.show(counter), counter}
  end

  @impl true
  def handle_cast(:inc, counter) do
    {:noreply, Counter.add(counter, 1)}
  end

  @impl true
  def handle_cast(:dec, counter) do
    {:noreply, Counter.add(counter, -1)}
  end
end
