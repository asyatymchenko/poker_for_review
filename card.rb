class Card
  attr_accessor :suit, :mark
  def initialize(suit:,mark:)
    @suit = suit
    @mark = mark
  end

  def self.print_card(card)
    puts "suit: #{card.suit},mark: #{card.mark}"
  end
end
