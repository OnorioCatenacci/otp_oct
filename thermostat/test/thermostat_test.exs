defmodule ThermostatTest do
  use ExUnit.Case
  doctest Thermostat

  test "greets the world" do
    assert Thermostat.hello() == :world
  end
end
