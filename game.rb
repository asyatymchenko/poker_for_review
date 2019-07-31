# frozen_string_literal: true

require_relative 'card'
require_relative 'player'
require_relative 'table'
require_relative 'deck'
require_relative 'combination'
# represents poker play
class Game
  # start game
  def play
    deck = Deck.new
    player = Player.new
    table = Table.new
    deck.pass_cards(player)
    deck.pass_cards(table)

    player.print_cards
    table.print_cards

    combination = Combination.new(player.cards, table.cards)
    puts combination.print_win_combination
  end

  # count iterations required to get specific combination
  def count_iterations(combination_to_find)
    iterations_counter = 1
    start_time = Time.now
    win = @combination.win_combination
    while win != combination_to_find
      iterations_counter += 1
      fill_cards
      @combination = Combination.new(@player_cards, @desk_cards)
      win = @combination.win_combination
    end
    end_time = Time.now
    puts "iterations for #{combination_to_find}: #{iterations_counter};  time: #{end_time - start_time}"
  end
end

game = Game.new
game.play
# game.count_iterations('straight')
