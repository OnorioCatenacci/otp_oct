defmodule LingoTest do
  use ExUnit.Case
  doctest Lingo

  test "greets the world" do
    assert Lingo.hello() == :world
  end
end
