defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Create a deck of cards.

  ## Examples

      iex> Cards.create_deck
      ["",""]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", 
              "Nine", "Ten", "Jack", "Queen", "King"]
    suits  = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do "#{value} of #{suit}"; end
  end

  @doc """
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Deal some cards from a deck.

  ## Examples

      iex> Cards.create_deck |> Cards.shuffle |> Cards.deal(3)
      {["Five of Spades", "King of Hearts", "Seven of Clubs"], [...]}
  """
  def deal(deck, hand) do
    Enum.split(deck, hand)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "Cannot read file '#{filename}'."
    end
  end

end
