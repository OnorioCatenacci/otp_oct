defmodule Thermostat.Counter do
   def new(input) do
    String.to_integer(input)
   end
   def add(acc, i) do
    acc + i
   end
   def show(acc) do
    to_string(acc)
   end
  end
