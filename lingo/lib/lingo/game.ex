defmodule Lingo.Game do
  alias Lingo.Word
  alias IO.ANSI

  defstruct [
    :answer,
    guesses: [],
    legal_words: []
  ]

  defp initialize_word_list() do
    path = "./priv/words.txt"
    {:ok, contents} = path |> File.read()
    contents |> String.split("\n")
  end

  def random_word() do
    initialize_word_list() |> Enum.random()
  end

  def new() do
    answer = random_word()

    %__MODULE__{
      answer: answer,
      legal_words: initialize_word_list()
    }
  end

  def move(game, guess) do
    if Enum.member?(game.legal_words, guess) do
      score = Word.build_score(game.answer, guess)
      guess_list = [score | game.guesses] |> Enum.reverse()
      {:ok, %{game | guesses: guess_list}}
    else
      {:error, game}
    end
  end

  def show(%__MODULE__{guesses: g}) do
    g
    |> Enum.each(fn score ->
      Enum.reduce(score, "", fn e, acc -> acc <> show_letter(e) end)
      |> IO.puts()
    end)
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
