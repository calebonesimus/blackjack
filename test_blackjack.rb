require 'minitest/autorun'
require_relative 'blackjack'

class BlackJackTest < MiniTest::Test

  def test_win_should_add_to_win_count
    game = Game.new
    game.player_hand = [Card.new(10, "spades"), Card.new("Ace", "hearts")]
    game.winning_logic(game.player_hand, true)
    assert game.player_wins == 1
  end

  def test_player_wins_with_6_cards_under_21
    game = Game.new
    game.player_hand = [Card.new(2, "spades"),
                        Card.new(2, "spades"),
                        Card.new(2, "spades"),
                        Card.new(2, "spades"),
                        Card.new(2, "spades"),
                        Card.new(2, "spades")]


    game.winning_logic(game.player_hand, true)
    assert game.player_wins == 1
  end

  def test_equal_totals_go_to_card_count
    game = Game.new
    game.player_hand = [Card.new(10, "spades"),
                        Card.new(2, "hearts"),
                        Card.new(3, "diamonds")]

    game.dealer_hand = [Card.new(10, "clubs"),
                        Card.new(5, "spades")]

    game.winning_logic(nil, true)
    assert game.player_wins == 1
  end

end
