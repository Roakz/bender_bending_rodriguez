require_relative 'error'

class GameBoard 

  attr_accessor :validate_movement
        
    def validate_movement(current_location_obj)

      @flipped_y = y_mapper(current_location_obj[:y])
      @x = current_location_obj[:x].to_i
      @result = case current_location_obj[:facing]

      when "NORTH"
        [0,1,2,3,4].include?(@flipped_y - 1)
      when "EAST"
        [0,1,2,3,4].include?(@x + 1)
      when "SOUTH"
        [1,2,3,4].include?(@flipped_y + 1)
      when "WEST"
        [1,2,3,4].include?(@x - 1)
      end

      if @result == false
        begin
          raise InvalidMovementError
        rescue InvalidMovementError => error
          puts error.message
          return false
        end
      else
        true
      end
    end

    private

    def y_mapper(y)
      @result = case y.to_i
        when 0 then 4
        when 1 then 3
        when 2 then 2
        when 3 then 1
        when 4 then 0
      end
      return @result
    end
  end