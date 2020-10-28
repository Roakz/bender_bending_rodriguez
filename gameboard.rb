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
      
      def validate_placement(placement_object)
        # check bounds of gameboard
        # throw error if invalid be sure to rescue it the other end.
      end
  
      def validate_movement
      end
  end