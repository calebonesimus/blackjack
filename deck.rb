require_relative 'card'

class Deck

  attr_accessor :number_of_cards,
                :faces,
                :cards,
                :suits

  def initialize
    @suits = ["clubs", "spades", "hearts", "diamonds"]
    @faces = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]

    @cards = Array.new
    create_deck

    # Set a discard pile
    @number_of_cards = self.cards.length
  end

  # Form a 52 card deck and shuffle it
  def create_deck
    suits.each do |suit|
      faces.each do |face|
        cards << Card.new(face, suit)
      end
    end
    shuffle!
  end

  # Call shuffle on deck object
  def shuffle!
    self.cards.shuffle!
  end

  def empty?
    self.cards.empty?
  end

end # end Deck class

class Shoe < Deck

  def create_deck
    7.times do
      super
    end
    shuffle!
  end

end
