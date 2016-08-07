require "spec_helper"

RSpec.describe Deck do

  let(:deck) { Deck.new }

  describe "#build_deck" do
    it "builds a deck of 52 cards" do
      expect(deck.cards.size).to eq 52
    end

    it "creates unique cards" do
      expect(deck.cards.uniq.size).to eq 52
    end

    it "shuffles deck after being built" do
      first_thirteen = deck.cards[1..13]
      expect(first_thirteen.all? {|card| card.suit == "♦" }).to be false
    end

    it 'creates an array of card objects' do
      expect(deck.cards.all? {|card| card.class == Card}).to be true
    end
  end

  describe "#deal" do
    it "removes one card from deck" do
      start_size = deck.cards.size
      deck.deal

      expect(deck.cards.size).to eq (start_size - 1)
    end

    it "deals the top card in the deck" do
      correct_card = deck.cards[0]
      expect(deck.deal).to eq correct_card
    end
  end
end
