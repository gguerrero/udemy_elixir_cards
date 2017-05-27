defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """


  @doc """
  Create a deck of cards.

  ### Examples

      iex> Cards.create_deck()
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
       "Five of Spades", "Six of Spades", "Seven of Spades", "Eight of Spades",
       "Nine of Spades", "Ten of Spades", "Jack of Spades", "Queen of Spades",
       "King of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
       "Four of Clubs", "Five of Clubs", "Six of Clubs", "Seven of Clubs",
       "Eight of Clubs", "Nine of Clubs", "Ten of Clubs", "Jack of Clubs",
       "Queen of Clubs", "King of Clubs", "Ace of Hearts", "Two of Hearts",
       "Three of Hearts", "Four of Hearts", "Five of Hearts", "Six of Hearts",
       "Seven of Hearts", "Eight of Hearts", "Nine of Hearts", "Ten of Hearts",
       "Jack of Hearts", "Queen of Hearts", "King of Hearts", "Ace of Diamonds",
       "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds",
       "Six of Diamonds", "Seven of Diamonds", "Eight of Diamonds",
       "Nine of Diamonds", "Ten of Diamonds", "Jack of Diamonds", ...]
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

      iex> Cards.create_deck() |> Cards.shuffle()
      ["Four of Diamonds", "Ace of Clubs", "Eight of Spades", "Two of Clubs",
       "Three of Clubs", "Three of Diamonds", "Jack of Spades", "Three of Spades",
       "Jack of Diamonds", "Eight of Clubs", "Nine of Clubs", "Queen of Diamonds",
       "Two of Spades", "Two of Hearts", "Three of Hearts", "King of Hearts",
       "Ace of Spades", "Two of Diamonds", "King of Spades", "Five of Spades",
       "Six of Clubs", "Ace of Diamonds", "Six of Spades", "Nine of Spades",
       "Four of Hearts", "Seven of Spades", "Ten of Clubs", "King of Clubs",
       "Ten of Hearts", "Eight of Diamonds", "Ten of Diamonds", "Seven of Hearts",
       "Five of Diamonds", "Jack of Clubs", "Queen of Spades", "Nine of Hearts",
       "Nine of Diamonds", "Five of Hearts", "Six of Hearts", "Ten of Spades",
       "Six of Diamonds", "Seven of Clubs", "Five of Clubs", "Ace of Hearts",
       "Seven of Diamonds", "Eight of Hearts", "King of Diamonds", "Four of Spades",
       "Four of Clubs", "Jack of Hearts", ...]
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end


  @doc """
  Check if a given `card` parameter exists within a given `deck` parameter.

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

      iex> {hand, deck} = Cards.create_deck() |> Cards.shuffle() |> Cards.deal(3)
      {["Five of Spades", "King of Hearts", "Seven of Clubs"], [...]}
      iex> hand
      ["Five of Spades", "King of Hearts", "Seven of Clubs"]
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
      iex> {hand, remainer} = Cards.create_hand(5)
      iex> hand
      ["Four of Hearts", "Ten of Diamonds", "Two of Diamonds", "King of Spades", "Ten of Clubs"]
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
