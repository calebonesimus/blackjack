require_relative 'deck'

class Player

  attr_accessor :name,
                :hand,
                :wins

  def initialize(name)
    @name = name
    @hand = []
    @wins = 0
  end

  def display_hand
    puts "\n"
    puts "Player hand:"
    hand.each do |card|
      puts "\t#{card.card_name}(#{card.power})"
    end
  end

  def card_total
    self.hand.inject(0) {|sum, card| sum + card.power}
  end

end # end Player class

class Dealer < Player

  def display_hand(hidden=true)
    puts "\n"
    if hidden
      puts "Dealer hand:"
      puts "\t#{self.hand[0].card_name}"
      puts "\tHIDDEN"
    else
      puts "Dealer hand:"
      hand.each do |card|
        puts "\t#{card.card_name}"
      end
    end
  end

end # end Dealer class
