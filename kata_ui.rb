require_relative 'lib/command_parser.rb'
require_relative 'lib/bitmap.rb'

bitmap = Bitmap

puts "Please first create a new bitmap with the I command\n"
loop do
  print '> '
  input = gets.strip
  begin
    bitmap = CommandParser.parse(input).apply(bitmap) if input != ''
  rescue RuntimeError => e
    puts e.message
  end
end
