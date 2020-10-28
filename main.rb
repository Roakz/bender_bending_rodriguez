class InvalidPlacementError < StandardError
	def message
		"Oh wait your serious... Let me laugh even harder!"
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


@gameboard = GameBoard.new


