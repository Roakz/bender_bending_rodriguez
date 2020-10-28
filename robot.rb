class BenderBendingRodriguez

  attr_accessor :x_axis, :y_axis, :facing
  
  def initialize(obj)
    @x_axis = obj[:x]
    @y_axis = obj[:y]
    @facing = obj[:bearing]
  end
end