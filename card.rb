# frozen_string_literal: true

# represents card in poker play
class Card
  attr_accessor :suit, :mark
  def initialize(suit:, mark:)
    @suit = suit
    @mark = mark
  end

  def print
    puts "suit: #{suit},mark: #{mark}"
  end
end
