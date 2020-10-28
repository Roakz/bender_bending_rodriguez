class BenderBendingRodriguez

  attr_accessor :x_axis, :y_axis, :facing, :place_bender, :placed, :report
  
  def initialize()
    @x_axis = nil
    @y_axis = nil
    @facing = nil
    @placed = false
  end

  def place_bender(placement_object)
    if !@placed 
      @placed = true
    end
    @x_axis = placement_object[:x]
    @y_axis = placement_object[:y]
    @facing = placement_object[:bearing]
    puts "Beep Boop, Bender is on the board."
  end

  def report
    puts "Your coordinates captain! X => #{@x_axis}, Y => #{@y_axis}, Facing => #{@facing}"
  end
end