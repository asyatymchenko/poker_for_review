# frozen_string_literal: true

require_relative 'deck'
require_relative 'shared_methods'
# represents player in poker play
class Player
  include SharedMethods

  CARDS_NUMBER = 2

  def initialize
    @cards = []
  end

  attr_reader :cards
end
