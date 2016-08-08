require_relative "deck"
require_relative "hand"
require_relative "card"
require 'pry'


class Blackjack
  attr_reader :deck, :player_hand, :dealer_hand

  def initialize
    @deck = Deck.new
    @player_hand = Hand.new
    @dealer_hand = Hand.new
  end

  def play_game
    start
    hit_or_stand
  end

  def start
    puts "Welcome to Blackjack!"
    deal_card(@player_hand)
    deal_card(@dealer_hand)
    deal_card(@player_hand)
    deal_card(@dealer_hand)
    puts "Player score: #{@player_hand.calculate_hand}"
  end

  def deal_card(player)
    new_card = @deck.deal
    player.cards << new_card
    if player == @player_hand
      puts "Player was dealt #{new_card.rank}#{new_card.suit}"
    end
  end

  def hit_or_stand
    puts "Hit or stand (H/S):"
    @input = gets.chomp.upcase
    until @input == "H" || @input == "S"
      puts "Invalid input, try again"
      @input = gets.chomp.upcase
    end


  end

end
