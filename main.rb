require 'tty-prompt'
require_relative 'error'
require_relative 'command_validator'
require_relative 'robot'
require_relative 'gameboard'
require_relative 'dispatch_controller'

DISPATCH_CONTROLLER = DispatchController.new
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
      DISPATCH_CONTROLLER.command_allocator(command.strip, bender, GAMEBOARD)
  	end
  end
end
