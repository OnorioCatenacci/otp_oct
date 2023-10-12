defmodule Lingo.Library do
  def initialize_word_list() do
    path = "./priv/words.txt"
    {:ok, contents} = path |> File.read()
    contents |> String.split("\n")
  end
end
