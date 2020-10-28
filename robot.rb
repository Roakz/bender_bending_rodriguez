class BenderBendingRodriguez

  attr_accessor :position, :facing
  
  def initialize(x, y, facing)
    @x_axis = x
    @y_axis = y
    @facing = facing
  end
end