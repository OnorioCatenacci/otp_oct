defmodule Thermostat.Server do
  use GenServer

  alias Thermostat.Counter
  # Client
  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def show(name) do
    GenServer.call(name, :show)
  end

  def inc(name) do
    GenServer.cast(name, :inc)
  end

  def dec(name) do
    GenServer.cast(name, :dec)
  end

  def boom(name) do
    GenServer.cast(name, :boom)
  end

  # Count Server
  def child_spec(name) do
    %{id: name, start: {__MODULE__, :start_link, [name]}}
  end

  @impl true
  def init(name) do
    IO.puts("We got to the init with #{name}")
    state = Counter.new("0")
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

  @impl true
  def handle_cast(:boom, _) do
    raise "boom"
  end
end
