require_relative "deck"
require_relative "hand"
require_relative "card"
require 'pry'


class Blackjack
  attr_reader :deck, :player_hand, :dealer_hand

  def initialize(deck_options = nil)
    @deck = Deck.new(deck_options)
    @player_hand = Hand.new
    @dealer_hand = Hand.new
  end

  def play_game
    start
    hit_or_stand
    if @player_hand.calculate_hand > 21
      puts "Bust! You lose..."
    else
      dealer_play
    end
  end

  def start
    puts "Welcome to Blackjack!"
    deal_card(@player_hand)
    deal_card(@dealer_hand)
    deal_card(@player_hand)
    deal_card(@dealer_hand)
    puts "Player score: #{@player_hand.calculate_hand}"
  end

  def deal_card(player, display = nil)
    new_card = @deck.deal
    player.cards << new_card
    if player == @player_hand
      puts "Player was dealt #{new_card.rank}#{new_card.suit}"
    end
    if player == @dealer_hand && display == "display"
      puts "Dealer was dealt #{new_card.rank}#{new_card.suit}"
    end
  end

  def hit_or_stand
    puts "Hit or stand (H/S):"
    @input = gets.chomp.upcase
    until @input == "H" || @input == "S"
      puts "Invalid input, try again"
      @input = gets.chomp.upcase
    end
    if @input == "H"
      deal_card(@player_hand)
      puts "Player score: #{@player_hand.calculate_hand}"
      if @player_hand.calculate_hand < 21
        hit_or_stand
      end
    elsif @input == "S"
      puts "Player score: #{@player_hand.calculate_hand}"
    end
  end

  def dealer_play
    @dealer_hand.cards.each do |card|
      puts "Dealer was dealt #{card.rank}#{card.suit}"
    end
      puts "Dealer score: #{@dealer_hand.calculate_hand}"
    until @dealer_hand.calculate_hand >= 17
      puts "Dealer hits."
      deal_card(@dealer_hand, "display")
      puts "Dealer score: #{@dealer_hand.calculate_hand}"
    end
    if @dealer_hand.calculate_hand > 21
      puts "Bust! You win!"
    elsif @dealer_hand.calculate_hand > @player_hand.calculate_hand
      puts "Dealer stands."
      puts "Dealer wins!"
    else
      puts "Dealer stands."
      puts "You win!"
    end
  end
end
