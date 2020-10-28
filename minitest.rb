require "minitest/autorun"
require_relative "command_validator"
require_relative "gameboard"
require_relative "robot"
require_relative "error"

class BenderBendingRodriguezTests < Minitest::Test

  def setup  
    @gameboard = GameBoard.new.gameboard
    @valid_bender = BenderBendingRodriguez.new({:x => 1, :y => 4, :bearing => "NORTH"})
    @command_validator = CommandValidator.new
  end

  def test_gameboard_size_equals_5x5
   assert_equal 5, @gameboard.length
   @gameboard.each {|row| assert_equal 5, row.length }
  end

  def test_invalid_basic_command_throws_error
    assert_raises InvalidCommandError do
      @command_validator.validate_command("TEST")
    end
  end

  def test_valid_command_doesnt_raise
    # Test automatically fails if an error is raised
    @command_validator.validate_command("PLACE 4,3,NORTH")
    @command_validator.validate_command("MOVE")
  end

  def test_invalid_place_command_throws_error
    assert_raises InvalidCommandError do
      @command_validator.validate_command("PLACE 4,5,WESTERLY")
    end
    assert_raises InvalidCommandError do
      @command_validator.validate_command("PLACE 4,6,WEST")
    end
    assert_raises InvalidCommandError do
      @command_validator.validate_command("PLACE 0,5,WEST")
    end
    assert_raises InvalidCommandError do
      @command_validator.validate_command("PLACE,4,5,WEST")
    end
  end

  def test_bender_object_initialized_with_placement_bearings
    assert_equal 1, @valid_bender.x_axis
    assert_equal 4, @valid_bender.y_axis
    assert_equal "NORTH", @valid_bender.facing
  end

  def test_movement_must_be_valid
    skip
  end
end