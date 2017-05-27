defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """


  @doc """
  Create a deck of cards.

  ### Examples

      iex> Cards.create_deck() |> Enum.slice(0,26)
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
       "Five of Spades", "Six of Spades", "Seven of Spades", "Eight of Spades",
       "Nine of Spades", "Ten of Spades", "Jack of Spades", "Queen of Spades",
       "King of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
       "Four of Clubs", "Five of Clubs", "Six of Clubs", "Seven of Clubs",
       "Eight of Clubs", "Nine of Clubs", "Ten of Clubs", "Jack of Clubs",
       "Queen of Clubs", "King of Clubs"]
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", 
              "Nine", "Ten", "Jack", "Queen", "King"]
    suits  = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do "#{value} of #{suit}"; end
  end


  @doc """
  Returns a shuffle deck (random order).

  ### Examples

      iex> Cards.create_deck() |> Cards.shuffle() |> Enum.count
      52
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end


  @doc """
  Determines whether a deck contains a given card.

  ### Examples

      iex> Cards.create_deck() |> Cards.contains?("Two of Hearts")
      true
      iex> Cards.create_deck() |> Cards.contains?("Fourty two of Rocks")
      false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end


  @doc """
  Deal some cards from a deck.
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` parameter indicates how many cards should be in the hand.
  If no `hand_size` is given, only one cards is returned as the hand.

  ### Examples

      iex> {hand, _remainder} = Cards.create_deck() |> Cards.deal(3)
      iex> hand
      ["Ace of Spades", "Two of Spades", "Three of Spades"]
  """
  def deal(deck, hand_size \\ 1) do
    Enum.split(deck, hand_size)
  end


  @doc """
  Save a given `deck` into a specified `filename`.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end


  @doc """
  Load and return a deck of cards from given `filename`.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "Cannot read file '#{filename}'."
    end
  end

  @doc """
  Create, shuffle and deal a hand of cards.
  The `hand_size` parameter indicates how many cards should be in the hand.

  ### Examples
      iex> {hand, _remainder} = Cards.create_hand(5)
      iex> hand |> Enum.count
      5
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
