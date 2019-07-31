# frozen_string_literal: true

require_relative 'card'
# represents deck of cards in poker play
class Deck
  def initialize
    @cards = []
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].each do |marks|
      %w[C D H S].each do |suits|
        @cards << Card.new(suit: suits, mark: marks)
      end
    end
    @cards.shuffle!
  end

  attr_reader :cards

  def pass_cards(reciever)
    Object.const_get("#{reciever.class}::CARDS_NUMBER").times { reciever.cards << give_card }
  end

  private

  def give_card
    cards.delete(cards.sample)
  end
end
