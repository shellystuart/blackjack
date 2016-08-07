class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def type
    if rank == 'J' || rank == 'Q' || rank == 'K'
      "face card"
    elsif
      rank == 'A'
      "ace"
    else
      "number card"
    end
  end
end
