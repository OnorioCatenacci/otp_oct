defmodule Lingo.Word do
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
        color != :green and ch == letter
      end)
      |> elem(1)

    List.replace_at(word, index, {letter, :black})
  end
end
