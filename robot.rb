class BenderBendingRodriguez

  attr_accessor :x_axis, :y_axis, :facing, :place_bender, :placed, :report, :rotate_left, :rotate_right
  
  def initialize()
    @x_axis = nil
    @y_axis = nil
    @facing = nil
    @placed = false
  end

  def place_bender(placement_object)
    if !@placed 
      @placed = true
      puts "Beep Boop, Bender is on the board."
    end
    @x_axis = placement_object[:x]
    @y_axis = placement_object[:y]
    @facing = placement_object[:bearing]
  end

  def rotate_left
    @result = case @facing
    when "NORTH"
      "WEST"
    when "EAST"
      "NORTH"
    when "SOUTH"
      "EAST"
    when "WEST"
      "SOUTH"
    end
    @facing = @result
  end

  def rotate_right
    @result = case @facing
    when "NORTH"
      "EAST"
    when "EAST"
      "SOUTH"
    when "SOUTH"
      "WEST"
    when "WEST"
      "NORTH"
    end
    @facing = @result
  end

  def report
    puts "Your coordinates captain! X => #{@x_axis}, Y => #{@y_axis}, Facing => #{@facing}"
  end
end