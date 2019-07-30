require_relative 'deck'
class Player
  attr_reader :cards_in_hand
  def initialize
    @cards_in_hand=[]
    get_cards
  end

  def get_cards
    2.times{@cards_in_hand<<Deck.give_card}
  end

  def print_player_cards
    puts 'Player cards:'
    @cards_in_hand.each {|card| Card.print_card(card) }
  end
end