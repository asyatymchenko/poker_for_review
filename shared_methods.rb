# frozen_string_literal: true

# method that prints cards owner name and each card
module SharedMethods
  def print_cards
    puts "#{self.class} cards:"
    cards.each(&:print)
  end
end
