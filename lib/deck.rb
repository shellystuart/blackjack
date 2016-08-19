require_relative "card"

class Deck
  SUITS = ['♦', '♣', '♠', '♥']
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  attr_accessor :cards

  def initialize(options = nil)
    @cards = build_deck(options)
  end

  def build_deck(options)
    cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(rank,suit)
      end
    end
    if options == "unshuffled"
      cards
    elsif options == "reversed"
      cards.reverse
    else
      cards.shuffle
    end
  end

  def deal
    cards.shift
  end
end
