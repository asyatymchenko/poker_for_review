# frozen_string_literal: true

require_relative 'card'
# represents combination of cards in poker play
class Combination
  def initialize(player_cards, desk_cards)
    @cards = []
    player_cards.each { |card| @cards << card }
    desk_cards.each { |card| @cards << card }
    @same_suit_cards = same_suit_cards
    @same_mark_cards = same_mark_cards
    @same_rank_cards = same_rank_cards
  end

  private

  # rubocop disable:Metrics/CyclomaticComplexity
  def win_combination
    return 'royal_flush' if royal_flush?
    return 'straight_flush' if straight_flush?
    return 'four_of_a_kind' if four_of_a_kind?
    return 'full_house' if full_house?
    return 'flush' if flush?
    return 'straight' if straight?
    return 'three_of_a_kind' if three_of_a_kind?
    return 'two_pair' if two_pair?
    return 'pair' if pair?

    'high_card'
  end
  # rubocop enable:Metrics/CyclomaticComplexity

  def print_win_combination
    puts "Combination: #{win_combination}"
  end

  def royal_flush?
    straight_flush? && @same_mark_cards[0].mark == 14
  end

  def straight_flush?
    @same_suit_cards = sort_card_by_marks(@same_suit_cards)
    @same_suit_cards.size >= 5 && @same_mark_cards.size >= 5 && @same_suit_cards == @same_mark_cards
  end

  def four_of_a_kind?
    @same_rank_cards.value?(4)
  end

  def full_house?
    three_of_a_kind? && count_pair >= 1
  end

  def flush?
    @same_suit_cards.size >= 5
  end

  def straight?
    @same_mark_cards.size >= 5
  end

  def three_of_a_kind?
    @same_rank_cards.value?(3)
  end

  def two_pair?
    count_pair >= 2
  end

  def pair?
    count_pair == 1
  end

  # returns number of pairs in combination
  def count_pair
    counter = 0
    @same_rank_cards.each { |_k, v| counter += 1 if v == 2 }
    counter
  end

  # returns largest array filled by cards with same suit
  def same_suit_cards
    @same_suit_cards ||=  begin
                          suit_counter = Array.new(1, 0)
                          iterator = 0

                          sorted_cards = @cards.sort_by(&:suit)
                          sorted_cards.each_with_index { |card, index| index.zero? || card.suit == sorted_cards[index - 1].suit ? suit_counter[iterator] += 1 : suit_counter[iterator += 1] = 1 }

                          fill_result_array(suit_counter, sorted_cards)
                          end
  end

  # returns largest array filled by cards with same mark
  def same_mark_cards
    @same_mark_cards ||=  begin
                          marks_counter = Array.new(1, 0)
                          iterator = 0

                          sorted_cards = sort_card_by_marks(@cards)
                          sorted_cards.each_with_index { |card, index| index.zero? || card.mark == (sorted_cards[index - 1].mark - 1) ? marks_counter[iterator] += 1 : marks_counter[iterator += 1] = 1 }

                          fill_result_array(marks_counter, sorted_cards)
                          end
  end

  # returns hash filled by cards with same mark and their frequency
  def same_rank_cards
    @same_rank_cards ||=  begin
                          repeat_counter = Array.new(1, 0)
                          iterator = 0

                          sorted_cards = sort_card_by_marks(@cards)
                          sorted_cards.each_with_index { |card, index| index.zero? || card.mark == sorted_cards[index - 1].mark ? repeat_counter[iterator] += 1 : repeat_counter[iterator += 1] = 1 }

                          hash_with_ranks = {}
                          sorted_cards = clean_from_repetitions(sorted_cards)
                          repeat_counter.each_with_index { |value, index| hash_with_ranks[sorted_cards[index]] = value }

                          hash_with_ranks
                        end
  end

  # returns array filled by cards with unique marks
  def clean_from_repetitions(cards)
    result = []
    cards.each_with_index { |card, index| result << card if index.zero? || card.mark != cards[index - 1].mark }
    result
  end

  # returns array with cards sorted by marks
  def sort_card_by_marks(cards)
    sorted_cards = cards
    sorted_cards.sort_by(&:mark).reverse
  end

  # returns array with cards that fits specific condition
  def fill_result_array(counter, cards)
    iterator = 0
    result_array = []

    (0...counter.index(counter.max)).to_a.each { |x| iterator += counter[x] }
    i = iterator
    while i < (iterator + counter.max)
      result_array << cards[i]
      i += 1
    end
    result_array
  end
end
