class Card

  attr_accessor :card_name,
                :face,
                :suit,
                :power

  def initialize(face, suit)
    @card_name = "#{face} of #{suit}"
    @face = face
    @suit = suit
    @power = find_power
  end

  # Creates power levels for each card
  # Set up for blackjack
  def find_power
    if self.face.is_a? Integer
      self.power = self.face
    elsif self.face == "Jack"
      self.power = 10
    elsif self.face == "Queen"
      self.power = 10
    elsif self.face == "King"
      self.power = 10
    elsif self.face == "Ace"
      self.power = 11
    end
  end

end
