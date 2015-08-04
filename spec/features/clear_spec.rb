require_relative './feature_helper.rb'

feature 'user clears an image' do
  let(:clear) { 'C' }

  before do
    @bitmap = create_5_x_5
    @bitmap.fill(Coord.new(1, 1), Colour.new('X'))
  end

  scenario 'with a valid height and width' do
    expect { @bitmap.show }
      .to output("XXXXX\n" * 5).to_stdout

    CommandParser.parse(clear).apply(@bitmap)

    expect { @bitmap.show }
      .to output("00000\n00000\n00000\n00000\n00000\n").to_stdout
  end
end
