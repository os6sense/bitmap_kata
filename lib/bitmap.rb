require_relative 'colour.rb'
require_relative 'bitmap_presenter.rb'

# It is assumed from the spec that the m * n array is specifying row major
# order hence height * width
class Bitmap
  class << self
    def create(height, width, default_colour)
      Array.new(height) { Array.new(width) { default_colour } }
    end
  end

  def initialize(height, width, default_colour = Colour.new('0'))
    @bitmap = self.class.create(height, width, default_colour)
  end

  def clear
    @bitmap.each { |row| row.each(&:reset) }
  end

  def [](row, col)
    @bitmap[row][col]
  end

  def []=(row, col, value)
    @bitmap[row][col] = value
  end

  def drawline(coord1, coord2, colour)
    (coord1.x).upto(coord2.x) do |row|
      (coord1.y).upto(coord2.y) do |col|
        @bitmap[row][col] = colour
      end
    end
  end

  #* F X Y C - Fill the region R with the colour C. R is defined as:
  #Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y)
  #and shares a common side with any pixel in R also belongs to this region.
  def fill

  end

  def show(out: STDOUT, presenter: BitmapPresenter.new)
    presenter.show(@bitmap, out: out)
  end
end
