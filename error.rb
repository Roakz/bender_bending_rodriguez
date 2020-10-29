class InvalidPlacementError < StandardError
  def message
  	"Invalid placement try again!"
  end
end

class InvalidCommandError < StandardError
  def message
  	"Invalid command! check the instructions and try again"
  end
end

class PlacementRequiredError < StandardError
  def message
    "Must place robot on the board first!"
  end
end

class InvalidMovementError < StandardError
  def message
	"Oh wait your serious... Let me laugh even harder! Try again!"
  end
end