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
