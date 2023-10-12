defmodule Lingo.Word do
  alias Lingo.Library

  @words Library.initialize_word_list()
  @set MapSet.new(@words)

  def random_word() do
    Enum.random(@words)
  end

  def member?(word) do
    MapSet.member?(@set, word)
  end

  # Find
  # - green
  # - black
  # - yellow
  def build_score(answer, guess) do
    answer = String.graphemes(answer)
    guess = String.graphemes(guess)

    greens =
      Enum.zip(answer, guess)
      |> Enum.map(&letter_green/1)

    misses = guess -- answer

    Enum.reduce(
      misses,
      greens,
      &replace_one_letter(&2, &1)
    )
  end

  def letter_green({a, a}), do: {a, :green}
  def letter_green({_, g}), do: {g, :yellow}

  def replace_one_letter(word, letter) do
    index =
      word
      |> Enum.with_index()
      |> Enum.find(fn {{ch, color}, _i} ->
        color == :yellow and ch == letter
      end)
      |> elem(1)

    List.replace_at(word, index, {letter, :black})
  end
end
