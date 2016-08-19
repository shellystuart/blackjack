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

    it "adds a card to the player's hand when hits" do
      allow(game_1).to receive(:gets).and_return("H", "S")
      game_1.start
      game_1.hit_or_stand

      expect(game_1.player_hand.cards.count).to eq(3)
    end

    it "does not add a card to the player's hand when stands" do
      allow(game_1).to receive(:gets).and_return("S")
      game_1.start
      game_1.hit_or_stand

      expect(game_1.player_hand.cards.count).to eq(2)
    end

    it "allows the user to continue hitting until they are at or above 21" do
      game_2 = Blackjack.new("unshuffled")
      allow(game_2).to receive(:gets).and_return("H")
      expect { game_2.play_game }.to output(/Bust! You lose.../).to_stdout
      expect(game_2.player_hand.cards.count).to eq(5)
      expect(game_2.player_hand.calculate_hand).to eq(27)
    end
  end

  describe "#dealer_play" do
    it "displays the two cards in the dealer's hand" do
      game_2 = Blackjack.new("unshuffled")
      game_2.start
      expect { game_2.dealer_play }.to output(/Dealer was dealt\s3♦\sDealer was dealt\s5♦/).to_stdout
    end

    it "adds cards until the dealer is at or above 17" do
      game_2 = Blackjack.new("unshuffled")
      game_2.start
      expect { game_2.dealer_play }.to output(/Dealer hits.\sDealer was dealt\s6♦\sDealer score: 14\sDealer hits.\sDealer was dealt\s7♦\sDealer score: 21\sDealer stands./).to_stdout
    end

    it "determines the player has won if the dealer busts" do
      game_2 = Blackjack.new("unshuffled")
      game_2.start
      allow(game_2).to receive(:gets).and_return("H", "H", "S")
      expect { game_2.hit_or_stand }.to output(/Player score: 19/).to_stdout
      expect { game_2.dealer_play }.to output(/Bust! You win!/).to_stdout
    end

    it "determines the player has won if the player's hand is greater than the dealer's" do
      game_2 = Blackjack.new("reversed")
      game_2.start
      allow(game_2).to receive(:gets).and_return("S")
      expect { game_2.hit_or_stand }.to output(/Player score: 21/).to_stdout
      expect { game_2.dealer_play }.to output(/Dealer stands.\sYou win!/).to_stdout
    end

    it "determines the dealer has won if the dealer's hand is greater" do
      game_2 = Blackjack.new("unshuffled")
      game_2.start
      expect { game_2.dealer_play }.to output(/Dealer wins!/).to_stdout
    end
  end
end
