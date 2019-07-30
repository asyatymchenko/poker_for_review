require_relative 'card'
require_relative 'player'
require_relative 'deck'
require_relative 'combination'
class Game
  def initialize
    @deck_cards = Deck.new
    fill_cards
  end

  def fill_cards
    @desk_cards = []
    @deck_cards.new_deck
    fill_desk
    player = Player.new
    @player_cards = player.cards_in_hand
    @combination = Combination.new(@player_cards, @desk_cards)
  end

  def fill_desk # fill array that represents desk cards
    5.times{@desk_cards<<Deck.give_card}
  end

  def play #start game
    puts @combination.print_win_combination
    puts "desk"
    print_cards(@desk_cards)
    puts "player"
    print_cards(@player_cards)
  end

  def count_iterations(combination_to_find) # count iterations required to get specific combination
    iterations_counter = 1
    start_time = Time.now
    win = @combination.win_combination
    while  win != combination_to_find
      iterations_counter += 1
      fill_cards
      @combination = Combination.new(@player_cards, @desk_cards)
      win = @combination.win_combination
    end
    end_time = Time.now
    puts "iterations for #{combination_to_find}: #{iterations_counter};  time: #{end_time - start_time}"
  end

  def print_cards(cards)
    cards.each {|card| Card.print_card(card) }
  end
end

game = Game.new
game.play
game.count_iterations('straight')