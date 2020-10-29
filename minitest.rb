require "minitest/autorun"
require_relative "command_validator"
require_relative "gameboard"
require_relative "robot"
require_relative "error"

class BenderBendingRodriguezTests < Minitest::Test

  def setup  
    @gameboard = GameBoard.new
    @valid_bender = BenderBendingRodriguez.new()
    @valid_bender.place_bender({:x => 1,:y => 4,:bearing => "NORTH"})
    @command_validator = CommandValidator.new
  end

  def test_gameboard_size_equals_5x5
   assert_equal 5, @gameboard.gameboard.length
   @gameboard.gameboard.each {|row| assert_equal 5, row.length }
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

  def test_bender_reports_as_expected
    assert_output(/Your coordinates captain! X => 1, Y => 4, Facing => NORTH/) { @valid_bender.report }
  end

  def test_movement_must_raise_when_not_valid
    assert_output(/Oh wait your serious... Let me laugh even harder! Try again!/) {@gameboard.validate_movement(:x => 0, :y => 0, :facing => "WEST")}
  end

  def test_rotation_changes_orientation
    @valid_bender.rotate_left
    assert_equal "WEST", @valid_bender.facing
    @valid_bender.rotate_right
    assert_equal "NORTH", @valid_bender.facing
  end 
end