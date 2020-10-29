require 'tty-prompt'
require_relative 'error'
require_relative 'command_validator'
require_relative 'robot'
require_relative 'gameboard'

def deconstruct_command(command)
	positions = command.split[1]
  {
		:x => positions.split(",")[0],
		:y => positions.split(",")[1],
		:bearing => positions.split(",")[2]
	}
end

def determine_y_axis_for_move(placement_obj, current_location_obj)
  y = current_location_obj[:y].to_i
  if current_location_obj[:facing] == "NORTH"
    placement_obj[:y] = y + 1
  elsif current_location_obj[:facing] == "SOUTH"
  placement_obj[:y] = y - 1
  else
  placement_obj[:y] = y
  end
end

def determine_x_axis_for_move(placement_obj, current_location_obj)
  x = current_location_obj[:x].to_i
  if current_location_obj[:facing] == "EAST"
    placement_obj[:x] = x + 1
  elsif current_location_obj[:facing] == "WEST"
  placement_obj[:x] = x - 1
  else
  placement_obj[:x] = x
  end
end

def place_action(validated_command, bender)
  placement_obj = deconstruct_command(validated_command)
  bender.place_bender(placement_obj)
end

def move_action(gameboard, bender)
  current_location_obj = {
    :x => bender.x_axis,
    :y => bender.y_axis,
    :facing => bender.facing
  }

  validated = gameboard.validate_movement(current_location_obj)
  if validated == false
    return
  end
  placement_obj = {
    :bearing => current_location_obj[:facing]
    }
  determine_y_axis_for_move(placement_obj, current_location_obj)
  determine_x_axis_for_move(placement_obj, current_location_obj)
  bender.place_bender(placement_obj)
end

def command_allocator(validated_command, bender, gameboard)
	case validated_command
	when "MOVE"
    move_action(gameboard, bender)
	when "LEFT"
    bender.rotate_left
	when "RIGHT"
    bender.rotate_right
  when "REPORT"
    bender.report
  else
    place_action(validated_command, bender)
	end
end

PROMPT = TTY::Prompt.new
GAMEBOARD = GameBoard.new
COMMAND_VALIDATOR = CommandValidator.new
bender = nil 

loop do
  command_line = false
  desired_action = PROMPT.select("Choose an action", %w(Instructions Commands Exit))
  
  case desired_action
  when "Instructions"
  	puts "Instructions Go here!"
  when "Commands"
  	command_line = true
  when "Exit"
  	exit
  end
  
  if command_line
  	loop do	  
      begin
  	  	puts bender && bender.placed ? "Enter your command" : "Enter your PLACE command to begin! < PLACE X,Y,FACING >"
  		  command = gets.chomp
  		  break if command == "EXIT"
        COMMAND_VALIDATOR.validate_command(command)
        bender = BenderBendingRodriguez.new unless bender
  	  rescue InvalidCommandError => error
  	  	puts error.message
  	  	next
  	  end
        if ! bender.placed
          begin
            raise PlacementRequiredError unless command.split[0] == "PLACE"
          rescue PlacementRequiredError => error
            puts error.message
            next
          end
        end
        command_allocator(command.strip, bender, GAMEBOARD)
  	end
  end
end
