require_relative "error"

class CommandValidator
	def validate_command(command)
		striped_command = command.strip
	  return true if %W(MOVE LEFT RIGHT REPORT).include? striped_command
	  if striped_command.split[0] == "PLACE" 
      # regex check
		end
		false
	end
end