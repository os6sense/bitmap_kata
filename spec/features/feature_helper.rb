require 'capybara/rspec'

require_relative '../../lib/command_parser.rb'
require_relative '../../lib/bitmap.rb'

def create_5_x_5
  CommandParser.parse('I 5 5').apply(Bitmap)
end
