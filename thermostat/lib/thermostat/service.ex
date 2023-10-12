defmodule Thermostat.Service do
  alias Thermostat.Counter

  # API

  def inc(counter_pid) do
    send(counter_pid, :inc)
  end

  def dec(counter_pid) do
    send(counter_pid, :dec)
  end

  def show(counter_pid) do
    send(counter_pid, {:show, self()})

    receive do
      msg -> msg
    end
  end

  def start(input) do
    spawn(fn -> input |> Counter.new() |> loop end)
  end

  # Server
  def loop(counter) do
    counter
    |> listen
    |> loop
  end

  def listen(counter) do
    receive do
      :inc ->
        Counter.add(counter, 1)

      :dec ->
        Counter.add(counter, -1)

      {:show, from_pid} ->
        send(from_pid, Counter.show(counter))
        counter
    end
  end
end
