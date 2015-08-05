require_relative '../lib/coord.rb'
require_relative '../lib/colour.rb'

# Parses a command string of the form documented below

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
class CommandParser
  class << self
    # parses a command string and returns an instance of a Command object.
    def parse(command)
      Command.new parseline(command)
    end

    private

    def parseline(line)
      line.split(' ')
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
    parse_command(args)
  end

  # Execute the command
  def apply(bitmap = nil)
    exit if @command == :exit
    bitmap.send(@command, *params)
  end

  private

  def parse_command(args)
    letter = args[0]
    fail "Unknown Command #{letter}" unless valid_command?(letter)

    @command = get_command(letter)

    fail_if_incorrect_number_of_arguments(@command, args)

    @coords = get_coord(args) if %w(I L F).include?(letter)
    @colour = get_colour(args) if %(L V H F).include?(letter)

    @coords, @coords2 = get_line_coords(args) if %w(V H).include?(letter)
  end

  def fail_if_incorrect_number_of_arguments(command, args)
    msg = "Incorrect number of arguments for command #{command}."
    len = args.size

    case command
    when :clear, :show, :exit, :rotate
      fail msg unless len == 1
    when :new
      fail msg unless len == 3
    when :drawline
      fail msg unless len == 5
    when :fill, :plot
      fail msg unless len == 4
    end
  end

  def get_line_coords(args)
    case args[0]
    when 'V'
      [new_coord(args[2], args[1]), new_coord(args[3], args[1])]
    when 'H'
      [new_coord(args[3], args[1]), new_coord(args[3], args[2])]
    end
  end

  def params
    [@coords, @coords2, @colour].compact
  end

  def new_coord(x, y)
    Coord.new(Integer(x), Integer(y))
  end

  def get_coord(args)
    new_coord(args[2], args[1])
  end

  def valid_command?(letter)
    COMMANDS.key?(letter.to_sym)
  end

  def get_command(letter)
    COMMANDS[letter.to_sym]
  end

  def get_colour(args)
    Colour.new(args[-1])
  end
end
