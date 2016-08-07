require "spec_helper"

describe Blackjack do

  let(:game_1) {Blackjack.new}


  it "creates a deck of cards" do
    expect(game_1.deck).to be_kind_of(Deck)
  end

  it "sets up a game with two cards for player" do
    expect(game_1.player_hand).to be_kind_of(Hand)
    expect(game_1.player_hand.cards.count).to eq(2)
  end

  it "sets up a game with two cards for dealer" do
    expect(game_1.dealer_hand).to be_kind_of(Hand)
    expect(game_1.dealer_hand.cards.count).to eq(2)
  end

  describe "#describe_hands" do
    it "tell us what cards were dealt" do
      expect(game_1.describe_hands).to be_a(String)
      expect(game_1.describe_hands).to include("Player was dealt #{game_1.player_hand.cards[0].rank}#{game_1.player_hand.cards[0].suit}\n")
      expect(game_1.describe_hands).to include("Player was dealt #{game_1.player_hand.cards[1].rank}#{game_1.player_hand.cards[1].suit}\n")
      expect(game_1.describe_hands).to include("Dealer was dealt #{game_1.dealer_hand.cards[0].rank}#{game_1.dealer_hand.cards[0].suit}\n")
      expect(game_1.describe_hands).to include("Dealer was dealt #{game_1.dealer_hand.cards[1].rank}#{game_1.dealer_hand.cards[1].suit}\n")
    end
  end

  describe "#hit_or_stand" do
    it "prompts the user to hit or stand" do
      allow(game_1).to receive(:gets).and_return("H")
      expect { game_1.hit_or_stand }.to output("Hit or stand (H/S):").to_stdout
    end

    it "notifies the user if the input is invalid and re-prompts" do
      allow(game_1).to receive(:gets).and_return("Q")
      expect { game_1.hit_or_stand }.to output("Invalid input, try again\n").to_stdout
    end

    it "allows uppercase or lowercase input" do
      allow(game_1).to receive(:gets).and_return("h")
      expect(game_1.hit_or_stand.input).to eq("H")
    end
  end





end
