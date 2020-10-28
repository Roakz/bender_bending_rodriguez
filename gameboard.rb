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