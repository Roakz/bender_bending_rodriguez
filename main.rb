require 'tty-prompt'
require_relative 'error'

class CommandValidator
	def validate_command(command)
		# work some validation magic here
	end
end

class GameBoard 

  attr_accessor :gameboard

  def initialize
    @gameboard = [[0,0,0,0,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0]
                ] 
	end
	
	def validate_placement
	end

	def validate_movement
	end
end

class BenderBendingRodriguez

	attr_accessor :position, :facing
  
	def initialize(x, y, facing)
		@x_axis = x
		@y_axis = y
    @facing = facing
	end

end

prompt = TTY::Prompt.new
gameboard = GameBoard.new
command_validator = CommandValidator.new
bender = nil 

continue = prompt.yes?("Ready to play?")
exit if !continue
	
desired_action = prompt.select("Choose an action", %w(Instructions Commands Exit))
command_line = false

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
	  	puts place ? "Enter your command to" : "Enter your PLACE command to begin! < PLACE X,Y,FACING >"
			command = gets.chomp
			break if command == "EXIT"
	  	command_validator.validate_command(command)
	  rescue InvalidCommandError
	  	puts InvalidCommandError.message
	  	next
		end
			# perform the placement or command , assign palce and next
	end
end
