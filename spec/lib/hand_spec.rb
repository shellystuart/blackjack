require "spec_helper"

RSpec.describe Hand do

  # These UTF-8 characters will be useful for making different hands:
  # '♦', '♣', '♠', '♥'

  let(:hand) { Hand.new([Card.new(8, "♦"), Card.new("J", "♦")]) }
  let(:second_hand) { Hand.new([Card.new("A", "♦"), Card.new("A", "♦")]) }
  let(:blackjack) { Hand.new([Card.new("A", "♦"), Card.new("J", "♦")]) }
  let(:third_hand) { Hand.new([Card.new(8, "♦"), Card.new("J", "♦"), Card.new("A", "♦")]) }
  let(:forth_hand) { Hand.new([Card.new(7, "♦"), Card.new(2, "♦"), Card.new("A", "♦"), Card.new("A", "♦")])}

  describe "#calculate_hand" do
    it "counts the number of aces" do
      blackjack.calculate_hand
      second_hand.calculate_hand
      expect(blackjack.ace_count).to eq(1)
      expect(second_hand.ace_count).to eq(2)
    end

    it "adds the non-ace and ace cards together" do
      expect(hand.calculate_hand).to eq(18)
      expect(second_hand.calculate_hand).to eq(12)
      expect(blackjack.calculate_hand).to eq(21)
      expect(third_hand.calculate_hand).to eq(19)
      expect(forth_hand.calculate_hand).to eq(21)
    end
  end
end
