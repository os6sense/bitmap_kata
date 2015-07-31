
# Represents an x, y co-ordinate within a matrix providing upper and lower
# bounds to the x and y values. Initializing x or y with a value outside the
# range min..max will result an an argument error. Default bounds of 0 to 250
# are provided.
class Coord
  attr_reader :x,
              :y

  attr_reader :min,
              :max

  def initialize(x, y, min: 0, max: 250)
    @min, @max = min, max

    self.x = x
    self.y = y
  end

  def x=(val)
    @x = test_bounds(val)
  end

  def y=(val)
    @y = test_bounds(val)
  end

  private

  # check if val is valid
  def test_bounds(val)
    return val if val >= @min && val <= @max

    fail ArgumentError,
         "Value #{val} is outside coordinate bounds (#{@min} - #{@max})."
  end
end
