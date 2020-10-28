require "minitest/autorun"
require_relative "main"

class BenderBendingRodriguezTests < Minitest::Test

  def setup  
    @gameboard = GameBoard.new.gameboard
    @valid_bender = BenderBendingRodriguez.new(1, 4, "north")
  end

  def test_gameboard_size_equals_5x5
   assert_equal 5, @gameboard.length
   @gameboard.each {|row| assert_equal 5, row.length }
  end

  def test_invalid_command_throws_error
    skip
  end

  def test_placement_must_be_valid
    # assert_raises InvalidPlacementError do
    #   @gameboard.validate_placement("PLACE 3,6,NORTH")
    # end
    skip
  end

  def test_movement_must_be_valid
    skip
  end
end