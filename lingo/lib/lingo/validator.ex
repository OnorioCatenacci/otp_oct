defmodule Lingo.Validator do
  alias Lingo.Game
  alias Lingo.Word

  def maybe_move(game, guess) do
    if Word.member?(guess) do
      {:ok, Game.move(game, guess)}
    else
      {:error, game}
    end
  end
end
