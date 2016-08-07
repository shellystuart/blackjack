require_relative "deck"
require_relative "hand"
require_relative "card"
require 'pry'


class Blackjack
  attr_reader :deck, :player_hand, :dealer_hand

  def initialize
    @deck = Deck.new
    @player_hand = Hand.new(deck.deal(2))
    @dealer_hand = Hand.new(deck.deal(2))
  end

  def start
    describe_hands
    hit_or_stand
  end

  def describe_hands
    output = ""
    player_hand.cards.each do |card|
      output += "Player was dealt #{card.rank}#{card.suit}\n"
    end
    dealer_hand.cards.each do |card|
      output += "Dealer was dealt #{card.rank}#{card.suit}\n"
    end
    #binding.pry
    output
  end

  def hit_or_stand
    print "Hit or stand (H/S):"
    @input = gets.chomp.upcase!
    until @input == "H" || @input == "S"
      puts "Invalid input, try again"
      @input = gets.chomp.upcase!
    end


  end

end
