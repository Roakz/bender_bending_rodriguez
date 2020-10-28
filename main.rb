require 'tty-prompt'
require_relative 'error'
require_relative 'command_validator'
require_relative 'robot'
require_relative 'gameboard'

prompt = TTY::Prompt.new
gameboard = GameBoard.new
command_validator = CommandValidator.new
bender = nil 
place = false
command_line = false

def deconstruct_command(command)
	positions = command.split[1]
  {
		:x => positions.split(",")[0],
		:y => positions.split(",")[1],
		:bearing => positions.split(",")[2]
	}
end

def place(command, bender)
	if ! bender 
		placement_obj = deconstruct_command(command)
		bender = BenderBendingRodriguez.new(placement_obj)
	end
	gameboard.validate_placement(placement_obj)
end

def command_allocator(command, bender)
	case command
	when "MOVE"
    move_bender
	when "LEFT"
    rotate_left
	when "RIGHT"
    rotate_right
	when command.match(/^PLACE [1-5],[1-5],(NORTH|EAST|SOUTH|WEST)$/)
		place(command, bender)
	end
end

desired_action = prompt.select("Choose an action", %w(Instructions Commands Exit))

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
	  	puts place ? "Enter your command" : "Enter your PLACE command to begin! < PLACE X,Y,FACING >"
			command = gets.chomp
			break if command == "EXIT"
			command_validator.validate_command(command)
	  rescue InvalidCommandError
	  	puts InvalidCommandError.message
	  	next
		end
			if !place raise PlacementRequiredError unless command.split[0] == "PLACE"
			command_allocator(command.strip, bender)
	end
end
