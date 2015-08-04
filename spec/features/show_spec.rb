require_relative './feature_helper.rb'

feature 'applies multiple commands' do
  let(:plot) { 'S' }
  let(:expected) { "JJJJJ\nJJZZJ\nJWJJJ\nJWJJJ\nJJJJJ\nJJJJJ\n" }

  before do
    @bitmap = CommandParser.parse('I 6 5').apply(Bitmap)
  end

  scenario 'When the list of commands is F, V, H, S ' do
    CommandParser.parse('F 3 3 J').apply(@bitmap)
    CommandParser.parse('V 2 3 4 W').apply(@bitmap)
    CommandParser.parse('H 3 4 2 Z').apply(@bitmap)
    expect { CommandParser.parse('S').apply(@bitmap) }
      .to output(expected).to_stdout
  end
end
