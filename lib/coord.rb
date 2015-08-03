
# Represents an x, y co-ordinate within a matrix providing upper and lower
# bounds to the x and y values. Initializing x or y with a value outside the
# range min..max will result an an argument error. Default bounds of 0 to 250
# are provided.
class Coord
  attr_reader :x,
              :y

  attr_reader :xmin,
              :xmax

  attr_reader :ymin,
              :ymax

  def initialize(x, y, xmin: 1, xmax: 250, ymin: 1, ymax: 250)
    @xmin, @xmax = xmin, xmax
    @ymin, @ymax = ymin, ymax

    self.x = x
    self.y = y
  end

  def x=(val)
    @x = val
  end

  def y=(val)
    @y = val
  end

  def valid?
    test_bounds(x, @xmin, @xmax) && test_bounds(y, @ymin, @ymax)
  end

  private

  # check if val is valid
  def test_bounds(val, min, max)
    if val >= min && val <= max
      true
    else
      false
    end
  end
end
