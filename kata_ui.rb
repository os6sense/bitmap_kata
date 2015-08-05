require_relative 'lib/command_parser.rb'
require_relative 'lib/bitmap.rb'

bitmap = Bitmap

loop do
  print '> '
  input = gets
  begin
    bitmap = CommandParser.parse(input).apply(bitmap)
  rescue Exception => e
    raise if e.class == SystemExit
    puts e.message
  end
end
