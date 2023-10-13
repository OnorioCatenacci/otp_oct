defmodule Lingo do
  def play(name) do
    DynamicSupervisor.start_child(:dynamic_sup, {Lingo.Server, name})
  end

  defdelegate move(name, guess), to: Lingo.Server
end
