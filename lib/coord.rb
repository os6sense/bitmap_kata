
# Represents an x, y co-ordinate within a matrix providing upper and lower
# bounds to the x and y values. Initializing x or y with a value outside the
# range min..max will result an an argument error. Default bounds of 0 to 250
# are provided.
class Coord
  attr_accessor :x,
                :y

  attr_reader :xmin,
              :xmax

  attr_reader :ymin,
              :ymax

  # Create a new coordinate pair; x an y are required but minimum and
  # maximum bounts can be set by using the named parameters xmin, xmax, ymin
  # and ymax
  def initialize(x, y, xmin: 1, xmax: 250,
                       ymin: 1, ymax: 250)
    @xmin, @xmax = xmin, xmax
    @ymin, @ymax = ymin, ymax

    self.x = x
    self.y = y
  end

  # returns true if both x and y are within the bounds of x and y min/max
  def valid?
    test_bounds(x, @xmin, @xmax) && test_bounds(y, @ymin, @ymax)
  end

  def to_s
    "[#{x}, #{y}]"
  end

  private

  # check if val is valid
  def test_bounds(val, min, max)
    val >= min && val <= max
  end
end
