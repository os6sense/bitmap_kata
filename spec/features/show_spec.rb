require_relative './feature_helper.rb'

feature 'applies multiple commands' do
  let(:plot) { 'S' }
  let(:expected) { "JJJJJ\nJJZZJ\nJWJJJ\nJWJJJ\nJJJJJ\nJJJJJ\n" }

  before do
    @bitmap = CommandParser.parse('I 5 6').apply(Bitmap)
  end

  scenario 'When the list of commands is I, F, V, H, S ' do
    CommandParser.parse('F 3 3 J').apply(@bitmap)
    CommandParser.parse('V 2 3 4 W').apply(@bitmap)
    CommandParser.parse('H 3 4 2 Z').apply(@bitmap)
    expect { CommandParser.parse('S').apply(@bitmap) }
      .to output(expected).to_stdout
  end

  let(:expected_1) { "00000\n00000\n0A000\n00000\n00000\n00000\n" }

  scenario 'when the list of commands is L, S' do
    CommandParser.parse("L 2 3 A").apply(@bitmap)
    expect { CommandParser.parse('S').apply(@bitmap) }
      .to output(expected_1).to_stdout
  end
end
