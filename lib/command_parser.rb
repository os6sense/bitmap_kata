# There are 9 supported commands:

# * I M N         Create a new M x N image with all pixels coloured white (O).
# * C             Clears the table, setting all pixels to white (O).
# * L X Y C       Colours the pixel (X,Y) with colour C.
# * V X Y1 Y2 C   Draw a vertical segment of colour C in column X between rows
#                 Y1 and Y2 (inclusive).
# * H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between
#                 columns X1 and X2 (inclusive).
# * F X Y C       Fill the region R with the colour C. R is defined as: Pixel
#                 (X,Y) belongs to R. Any other pixel which is the same colour
#                 as (X,Y) and shares a common side with any pixel in R also
#                 belongs to this region.
# * S             Show the contents of the current image
# * X             Terminate the session
# * R             Rotate the image 90 degress clockwise

require_relative '../lib/coord.rb'
require_relative '../lib/colour.rb'

class CommandParser
  class << self
    def parseline(line)
      line.split(' ')
    end

    def parse(command)
      Command.new parseline(command)
    end
  end
end

class Command
  attr_reader :command,
              :coords,
              :coords2,
              :colour

  COMMANDS = { 'I': :new,
               'C': :clear,
               'L': :plot,
               'V': :drawline,
               'H': :drawline,
               'F': :fill,
               'S': :show,
               'R': :rotate,
               'X': :exit }

  def initialize(args)
    @coords, @coords2, @colour = nil, nil, nil
    parse_command(args)
  end

  def parse_command(args)
    letter = args[0]
    fail "Unknown Command #{letter}" unless valid_command?(letter)

    @command = get_command(letter)
    @coords = get_coord(args) if %w(I L F).include?(letter)
    @colour = get_colour(args) if %(L V H F).include?(letter)

    @coords, @coords2 = get_line_coords(args) if %w(V H).include?(letter)
  end

  def get_line_coords(args)
    case args[0]
    when 'V'
      [new_coord(args[1], args[1]), new_coord(args[2], args[3])]
    when 'H'
      [new_coord(args[1], args[2]), new_coord(args[3], args[3])]
    end
  end

  def apply(bitmap)
    bitmap.send(@command, *params )
  end

  private

  def params
    [@coords, @coords2, @colour].compact

  end

  def new_coord(x, y)
    Coord.new(x.to_i, y.to_i)
  end

  def valid_command?(letter)
    COMMANDS.key?(letter.to_sym)
  end

  def get_coord(args)
    Coord.new(args[1].to_i, args[2].to_i)
  end

  def get_command(letter)
    COMMANDS[letter.to_sym]
  end

  def get_colour(args)
    Colour.new(args[-1])
  end

end
