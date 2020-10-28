class InvalidPlacementError < StandardError
	def message
		"Oh wait your serious... Let me laugh even harder!"
	end
end

class InvalidCommandError < StandardError
	def message
		"Invalid command! check the instructions and try again"
	end
end

class PlacementRequiredError
  def message
    "Must place robot on the board first!"
  end
end