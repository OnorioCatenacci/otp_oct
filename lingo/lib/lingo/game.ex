defmodule Lingo.Game do
  alias Lingo.Word
  alias IO.ANSI

  defstruct [
    :answer,
    guesses: []
  ]

  def new() do
    answer = Word.random_word()

    %__MODULE__{
      answer: answer
    }
  end

  def move(game, guess) do
    score = Word.build_score(game.answer, guess)
    guess_list = [score | game.guesses]
    %{game | guesses: guess_list}
  end

  def show(%__MODULE__{guesses: g}) do
    g
    |> Enum.reverse()
    |> Enum.map(fn score ->
      Enum.reduce(score, "", fn e, acc -> acc <> show_letter(e) end)
    end)
    |> Enum.join("\n")
  end

  defp show_letter({l, :green} = {l, _color}) do
    ANSI.black_background() <> ANSI.green() <> l <> ANSI.reset()
  end

  defp show_letter({l, :yellow} = {l, _color}) do
    ANSI.black_background() <> ANSI.yellow() <> l <> ANSI.reset()
  end

  defp show_letter({l, :black} = {l, _color}) do
    ANSI.black_background() <> ANSI.light_black() <> l <> ANSI.reset()
  end

  # Check if move is legal
  # - Word should be part of allowed words
end
