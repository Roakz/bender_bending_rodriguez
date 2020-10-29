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
    puts "INSTRUCTIONS\n
          - Leave caps on when in the command line to ensure valid commands\n
          - EXIT will bring you back ot the main menu\n
          - Choose a number from 1-4 for both your x and y axis and either NORTH | EAST | SOUTH | WEST\n
          - A valid PLACE command looks like this exactly(Where x and y are numbers from 0-4): PLACE X,Y,NORTH\n
          - MOVE will move in the direction you are facing by 1 increment towards the tables edge.\n
          - LEFT will move your orientation to the left i.e NORTH becomes WEST\n
          - RIGHT will nove your orientation to the right i.e NORTH becomes EAST\n
          - PLACE can be used at any time your in the command line. Simply run the command again\n
          - REPORT will show your current COORD's \n
          - Bender doesnt like being told to jump! don't take offence!"
          
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
