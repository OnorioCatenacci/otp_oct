defmodule Lingo.Game do
  alias Lingo.Word

  defstruct [
    :answer,
    guesses: []
  ]

  def random_word() do
    path = "./priv/words.txt"
    {:ok, contents} = path |> File.read()
    contents |> String.split("\n") |> Enum.random()
  end

  def new() do
    answer = random_word()

    %__MODULE__{
      answer: answer
    }
  end

  def move(game, guess) do
    score = Word.build_score(game.answer, guess)

    %{game | guesses: [score | game.guesses]}
  end

  def show(game) do
    ""
  end

  # Check if move is legal
  # - Word should be part of allowed words
end
