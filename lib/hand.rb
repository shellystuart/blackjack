class Hand
  attr_reader :ace_count, :cards

  def initialize(cards = [])
    @cards = cards
  end

  def calculate_hand
    @hand_score = 0
    @ace_count = 0
    card_calculation
    if @ace_count > 0
      ace_calculation
    end
    @hand_score
  end

  private

  def card_calculation
    @cards.each do |card|
      if card.rank == "A"
        @ace_count += 1
      elsif card.rank == "J" || card.rank == "Q" || card.rank == "K"
        @hand_score += 10
      else
        @hand_score += card.rank
      end
    end
  end

  def ace_calculation
    @ace_count.times do |x|
      if @hand_score + 11 > 21
        @hand_score += 1
      else
        @hand_score += 11
      end
    end
  end
end
