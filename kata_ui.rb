require 'readline'

require_relative 'lib/command_parser.rb'
require_relative 'lib/bitmap.rb'

help_msg = "Please first create a new bitmap with the I command\n"

bitmap = Bitmap
puts help_msg

while (input = Readline.readline('> ', true))
  begin
    bitmap = CommandParser.parse(input).apply(bitmap) if input != ''
  rescue RuntimeError => e
    puts e.message
  rescue ArgumentError => e
    puts e.message
  rescue NoMethodError
    if bitmap == Bitmap
      puts help_msg
    else
      puts 'Please use X to exit to create a new bitmap or C to clear'
    end
  end
end
