require_relative 'player'

class Game

  attr_accessor :deck,
                :player,
                :dealer

  def initialize
    @deck = Shoe.new.cards
    @player = Player.new("Player")
    @dealer = Dealer.new("Dealer")
  end

  # Basic game logic
  def play
    # Put two cards in each players hand
    self.dealer.hand += self.deck.pop(2)
    self.player.hand += self.deck.pop(2)
    show_hands
    ace_on_arrival?
    check_players(player)
  end

  def show_hands(hidden=true)
    dealer.display_hand(hidden)
    player.display_hand
  end

  # Check both players for blackjack, bust, over six,
  # Then allow specified player to play
  def check_players(turn)
    if blackjack?(dealer)
      winning_logic(dealer)
    elsif blackjack?(player)
      winning_logic(player)
    elsif bust?(dealer)
      winning_logic(player)
    elsif bust?(player)
      winning_logic(dealer)
    elsif over_six?
      winning_logic(player)
    else
      turn == player ? player_decision : dealer_decision
    end
  end

  def player_decision
    puts "\nWhat would you like to do? (hit/stay)"
    input = gets.chomp

    if input == "hit"
      self.player.hand.push(self.deck.pop)
      show_hands
      ace?
      check_players(player)
    elsif input == "stay"
      check_players(dealer)
    else
      puts "Please choose 'hit' or 'stay'."
      player_decision
    end
  end

  # Dealer decision
  def dealer_decision
    if dealer.card_total < 16
      self.dealer.hand.push(self.deck.pop)
      show_hands(false)
      check_players(dealer)
    elsif (16..20).include?(dealer.card_total)
      winning_logic
    end
  end

  # Determine ace value on initial deal
  def ace_on_arrival?
    player.hand.each do |card|
      if card.face == "Ace"
        puts "\nDo you want your 'Ace' to be 11 or 1?"
        input = gets.chomp
        if input == "11"
          card.power = 11
          show_hands
        elsif input == "1"
          card.power = 1
          show_hands
        else
          puts "\nPlease choose '11' or '1'."
          ace?
        end
      end
    end
  end

  # Find ace value for each hit
  def ace?
    if player.hand.last.face == "Ace"
      player.display_hand
      puts "\nDo you want your 'Ace' to be 11 or 1?"
      input = gets.chomp
      if input == "11"
        player.hand.last.power = 11
        show_hands
      elsif input == "1"
        player.hand.last.power = 1
        show_hands
      else
        puts "\nPlease choose '11' or '1'."
        ace?
      end
    end
  end

  # Check for blackjack
  def blackjack?(player)
    true if player.card_total == 21
  end

  # Check for six cards under 21
  def over_six?
    true if self.player.hand.length == 6
  end

  # Check for bust
  def bust?(player)
    true if player.card_total > 21
  end

  # Display winner based
  # If no winner is passed it will evaluate cards for
  # total card value and number of cards
  def winning_logic(winner=nil)
    puts "\n----------------- GAME OVER -----------------"
    show_hands(false)

    # Display winner if declared by bust or blackjack
    if winner == player
      puts "\nPlayer wins!"
      self.player.wins += 1
    elsif winner == dealer
      puts "\nDealer wins!"
      self.dealer.wins += 1
    else

      # Check for card totals and number of cards for winner
      if player.card_total == dealer.card_total
        if player.hand.length >= dealer.hand.length
          puts "\nPlayer wins!"
          self.player.wins += 1
        else
          puts "\nDealer wins!"
          self.dealer.wins += 1
        end
      else
        if player.card_total >= dealer.card_total
          puts "\nPlayer wins!"
          self.player.wins += 1
        else
          puts "\nDealer wins!"
          self.dealer.wins += 1
        end
      end
    end

    puts "\nPlayer score: #{player.wins} --- Dealer score: #{dealer.wins}"

  end

  def play_again?
    # Allow user to play again.
    puts "\nWould you like to play again? (yes/no)"
    input = gets.chomp
    if input == "yes"
      # Reset hands and push cards into discard
      self.player.hand, self.dealer.hand = [[], []]
      self.deck.shuffle!
      self.play
    elsif input == "no"
      puts "\nThanks for playing!"
      exit
    else
      puts "Please choose 'yes' or 'no'."
      play_again?
    end
  end

end # end BlackJack class

game = Game.new
game.play
