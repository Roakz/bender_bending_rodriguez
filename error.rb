class InvalidPlacementError < StandardError
  attr_reader :message
  def message
  	"Oh wait your serious... Let me laugh even harder!"
  end
end

class InvalidCommandError < StandardError
  attr_accessor :message  
  def message
  	"Invalid command! check the instructions and try again"
  end
end

class PlacementRequiredError
  attr_reader :message
  def message
    "Must place robot on the board first!"
  end
end