require_relative 'colour.rb'
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

  # Access an element of the bitmap using a +Coordinate+
  def at(coords)
    self[coords.x, coords.y]
  end

  # Set an element of the bitmap to +value+ using a +Coordinate+
  def set_at(coords, value)
    self[coords.x, coords.y] = value
  end

  # "Raw" row and column based reader for values
  def [](row, col)
    @bitmap[row][col]
  end

  # "Raw" row and column based writer for values
  def []=(row, col, value)
    @bitmap[row][col] = value
  end

  # Draw a line between two coordinate pairs using the supplied +colour+
  #
  # PARAMS
  # +coord1+:: Starting coordinate
  # +coord2+:: finishing coordinate
  # +colour+:: Colour to fill the line colour with
  def drawline(coord1, coord2, colour)
    x_start, x_end = coord1.x, coord2.x
    y_start, y_end = coord1.y, coord2.y

    x_increment = x_end - x_start <=> 0
    y_increment = y_end - y_start <=> 0

    return if x_increment == 0 && y_increment == 0

    x, y = x_start, y_start

    while (x_increment > 0 ? x <= x_end : x >= x_end) &&
          (y_increment > 0 ? y <= y_end : y >= y_end)

      @bitmap[x][y] = colour

      x += x_increment
      y += y_increment
    end
  end

  #* F X Y C - Fill the region R with the colour C. R is defined as:
  #Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y)
  #and shares a common side with any pixel in R also belongs to this region.
  def fill(coords, colour)
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
end
