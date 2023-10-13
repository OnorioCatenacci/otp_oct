defmodule Lingo.Word do
  defstruct [
    :words,
    :set
  ]

  use GenServer

  alias Lingo.Library

  # API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :unused, name: :library)
  end

  def random_word() do
    GenServer.call(:library, :random)
  end

  def member?(word) do
    GenServer.call(:library, {:member, word})
  end

  # Server
  def init(_) do
    words = Library.initialize_word_list()
    {:ok, %__MODULE__{words: Enum.shuffle(words), set: MapSet.new(words)}}
  end

  def handle_call(:random, _from, %{words: [head | tail]} = words) do
    new_state = %{words | words: tail}
    {:reply, head, new_state}
  end

  def handle_call({:member, word}, _from, %{set: set} = words) do
    {:reply, MapSet.member?(set, word), words}
  end

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
