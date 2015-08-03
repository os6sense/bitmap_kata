require_relative 'colour.rb'
require_relative 'coord.rb'
require_relative 'bitmap_presenter.rb'

# It is assumed from the spec that the m * n array is specifying row major
# order hence height * width
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

  def initialize(height, width, default_colour = Colour.new('0'))
    @height, @width = height, width

    @bitmap = self.class.create(@height, @width, default_colour)
  end

  # Resets the value of each element/pixel of the bitmap to Colour::DEFAULT
  def clear
    @bitmap.each { |row| row.each(&:reset) }
  end

  # "Raw" row and column based reader for values
  def [](row, col)
    at(new_coord(row + 1, col + 1))
  end

  # "Raw" row and column based writer for values
  def []=(row, col, value)
    new_coord(row + 1, col + 1).tap do | coord |
      set_at(coord, value)
    end
  end

  # Access an element of the bitmap using a +Coordinate+
  def at(coords)
    @bitmap[coords.x - 1][coords.y - 1]
  end

  # Set an element of the bitmap to +value+ using a +Coordinate+
  def set_at(coords, value)
    @bitmap[coords.x - 1][coords.y - 1] = value
  end

  # Draw a line between two coordinate pairs using the supplied +colour+
  #
  # PARAMS
  # +coord1+:: Starting coordinate
  # +coord2+:: finishing coordinate
  # +colour+:: Colour to fill the line colour with
  def drawline(coord1, coord2, colour)
    x_increment = (coord2.x - coord1.x) <=> 0
    y_increment = (coord2.y - coord1.y) <=> 0

    return if x_increment == 0 && y_increment == 0

    x, y = coord1.x, coord1.y

    while (x_increment > 0 ? x <= coord2.x : x >= coord2.x) &&
          (y_increment > 0 ? y <= coord2.y : y >= coord2.y)

      self[x, y] = colour

      x += x_increment
      y += y_increment
    end
  end

  # Fill the region R with the colour C. R is defined as:
  # Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y)
  # and shares a common side with any pixel in R also belongs to this region.
  def fill(coords, new_colour, original_colour = nil)
    return unless coords.valid?

    original_colour ||= at(coords)
    return if at(coords) != original_colour || at(coords) == new_colour

    set_at(coords, new_colour)

    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |x1, y1|
      fill(new_coord(coords.x + x1, coords.y + y1), new_colour, original_colour)
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
