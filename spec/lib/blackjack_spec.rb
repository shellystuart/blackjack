require "spec_helper"

describe Blackjack do

  let(:game_1) { Blackjack.new }

  it "creates a deck of cards" do
    expect(game_1.deck).to be_kind_of(Deck)
  end

  describe "#start" do
    it "sets up a game with two cards for player" do
      game_1.start
      expect(game_1.player_hand).to be_kind_of(Hand)
      expect(game_1.player_hand.cards.count).to eq(2)
    end

    it "sets up a game with two cards for dealer" do
      game_1.start
      expect(game_1.dealer_hand).to be_kind_of(Hand)
      expect(game_1.dealer_hand.cards.count).to eq(2)
    end

    it "outputs player card information" do
      expect { game_1.start }.to output(/Player was dealt\s([2-9]|10|[AJQK])[♦♣♠♥]\sPlayer was dealt\s([2-9]|10|[AJQK])[♦♣♠♥]/).to_stdout
    end
  end

  describe "#hit_or_stand" do
    it "prompts the user to hit or stand" do
      allow(game_1).to receive(:gets).and_return("H")
      expect { game_1.hit_or_stand }.to output(/Hit or stand/).to_stdout
    end

    it "notifies the user if the input is invalid and re-prompts" do
      allow(game_1).to receive(:gets).and_return("Q", "H")
      expect { game_1.hit_or_stand }.to output(/Invalid input, try again\n/).to_stdout
    end

    it "allows uppercase or lowercase input" do
      allow(game_1).to receive(:gets).and_return("h")
      expect { game_1.hit_or_stand }.not_to output(/Invalid input, try again\n/).to_stdout

      allow(game_1).to receive(:gets).and_return("s")
      expect { game_1.hit_or_stand }.not_to output(/Invalid input, try again\n/).to_stdout

      allow(game_1).to receive(:gets).and_return("H")
      expect { game_1.hit_or_stand }.not_to output(/Invalid input, try again\n/).to_stdout

      allow(game_1).to receive(:gets).and_return("S")
      expect { game_1.hit_or_stand }.not_to output(/Invalid input, try again\n/).to_stdout
    end
  end





end
