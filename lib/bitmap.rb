require_relative 'colour.rb'
require_relative 'coord.rb'
require_relative 'bitmap_presenter.rb'

# A simple bitmap class using row major ordering for coordinate pairs. For
# the most part it is neccessary to supply a Coord instance in order to
# reference a coordinate on which an operation should be performed. The
# exception to this are the +[]+ and +[]=+ methods which are accessed via
# x, y values. It should be noted that x, y coordinates will be converted
# into a Coord internally hence access which violates the bounds of the
# internal dimensions will be checked by calls to coord.valid?
class Bitmap
  attr_reader :height,
              :width

  class << self
    # Returns an array of +height+ Arrays. Each subarray is +width+ elements
    # long and populated with the value of +default_color+
    #
    # PARAMS
    # +height+:: The number of rows
    # +width+:: The number of columns
    # +default_colour+:: The default value with which each element will be
    # populated.
    def create(height, width, default_colour)
      Array.new(height) { Array.new(width) { default_colour } }
    end
  end

  def initialize(dimensions, default_colour = Colour.new('0'))
    @height, @width = dimensions.x, dimensions.y

    @bitmap = self.class.create(@height, @width, default_colour)
  end

  # Resets the value of each element/pixel of the bitmap to Colour::DEFAULT
  def clear
    @bitmap.each { |row| row.each(&:reset) }
  end

  # row and column based reader for values e.g. [x, y]
  def [](row, col)
    at(new_coord(row + 1, col + 1))
  end

  # row and column based writer for values e.g. [x, y] = Colour.new('X')
  def []=(row, col, value)
    new_coord(row + 1, col + 1).tap do |coord|
      plot(coord, value)
    end
  end

  # Access an element of the bitmap using a +Coord+
  def at(coord)
    fail "Invalid Coordinate Coord:#{coord}" unless coord.valid?
    @bitmap[coord.x - 1][coord.y - 1]
  end

  # Set an element of the bitmap to +value+ at +Coord+
  def plot(coord, value)
    fail "Invalid Coordinate Coord:#{coord}" unless coord.valid?
    @bitmap[coord.x - 1][coord.y - 1] = value
  end

  # Draw a line between two coordinate pairs using the supplied +colour+
  #
  # PARAMS
  # +coord1+:: Starting coordinate
  # +coord2+:: finishing coordinate
  # +colour+:: Colour to fill the line colour with
  def drawline(coord1, coord2, colour)
    fail "Invalid Coordinate Coord 1:#{coord}" unless coord1.valid?
    fail "Invalid Coordinate Coord 2:#{coord2}" unless coord2.valid?

    x_increment = (coord2.x - coord1.x) <=> 0
    y_increment = (coord2.y - coord1.y) <=> 0

    return if x_increment == 0 && y_increment == 0

    x, y = coord1.x, coord1.y

    while (x_increment > 0 ? x <= coord2.x : x >= coord2.x) &&
          (y_increment > 0 ? y <= coord2.y : y >= coord2.y)

      plot(new_coord(x, y), colour)

      x += x_increment
      y += y_increment
    end
  end

  # Fill a region R with a new colour. R is defined as:
  #
  # coord belongs to R. Any other pixel which is the same colour as coord
  # and shares a common side with any pixel in R, also belongs to this region.
  #
  # Note that this method works recursively and the param original_colour
  # is used by recursive calls.
  #
  # PARAMS
  # +coord+:: x,y coordinates of the region to fill
  # +new_colour+:: The colour to fill with
  def fill(coord, new_colour, original_colour = nil)
    fail "Invalid Coordinate :#{coord}" if !coord.valid? && original_colour.nil?
    return unless coord.valid?

    original_colour ||= at(coord)
    return if at(coord) != original_colour || at(coord) == new_colour

    plot(coord, new_colour)

    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |x1, y1|
      fill(new_coord(coord.x + x1, coord.y + y1), new_colour, original_colour)
    end
  end

  # Rotate the bitmap 90 degrees clockwisej
  def rotate
    @bitmap = @bitmap.transpose.map(&:reverse)
  end

  # Show the bitmap. By default the bitmap will be printed to STDOUT
  #
  # PARAMS
  # +out:+:: - named parameter. Set the output IO object (default: STDOUT)
  # +presenter:+:: named parameter. default ( BitmapPresenter instance )
  def show(out: $stdout, presenter: BitmapPresenter.new)
    presenter.show(@bitmap, out: out)
  end

  private

  def new_coord(x, y)
    Coord.new(x, y, xmax: height, ymax: width)
  end
end
