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

def place_action(validated_command, bender)
  placement_obj = deconstruct_command(validated_command)
  bender.place_bender(placement_obj)
end

def command_allocator(validated_command, bender)
	case validated_command
	when "MOVE"
    move_bender
	when "LEFT"
    rotate_left
	when "RIGHT"
    rotate_right
  when "REPORT"
    bender.report
  else
    place_action(validated_command, bender)
	end
end

prompt = TTY::Prompt.new
gameboard = GameBoard.new
command_validator = CommandValidator.new
bender = nil 

loop do
  command_line = false
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
  	  	puts bender && bender.placed ? "Enter your command" : "Enter your PLACE command to begin! < PLACE X,Y,FACING >"
  		  command = gets.chomp
  		  break if command == "EXIT"
        command_validator.validate_command(command)
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
        command_allocator(command.strip, bender)
  	end
  end
end
