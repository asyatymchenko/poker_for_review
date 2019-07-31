# frozen_string_literal: true

require_relative 'deck'
require_relative 'shared_methods'
# represents table with cards in poker play
class Table
  include SharedMethods

  CARDS_NUMBER = 5

  def initialize
    @cards = []
  end

  attr_reader :cards
end
