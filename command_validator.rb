require_relative "error"

class CommandValidator
	def validate_command(command)
		striped_command = command.strip
	  return true if %W(MOVE LEFT RIGHT REPORT).include? striped_command
	  if striped_command.split[0] == "PLACE" 
		puts striped_command.match(/^PLACE [1-5],[1-5],(NORTH|EAST|SOUTH|WEST)$/)
        return true if striped_command.match(/^PLACE [0-4],[1-4],(NORTH|EAST|SOUTH|WEST)$/)
	  end
	  raise InvalidCommandError
	end
end