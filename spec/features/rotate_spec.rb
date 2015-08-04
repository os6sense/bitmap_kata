
require_relative './feature_helper.rb'

feature 'Rotate an image 90 degrees clockwise' do
  let(:rotate) { 'R' }

  before do
    @bitmap = create_5_x_5
    @bitmap[0, 0] = Colour.new('1')
    @bitmap[0, 4] = Colour.new('2')
    @bitmap[4, 4] = Colour.new('3')
    @bitmap[4, 0] = Colour.new('4')

    expect { @bitmap.show }
      .to output("10002\n" + ("00000\n" * 3) + "40003\n").to_stdout

    CommandParser.parse(rotate).apply(@bitmap)
  end

  scenario 'When the corners are numbered' do
    expect { @bitmap.show }
      .to output("40001\n" + ("00000\n" * 3) + "30002\n").to_stdout
  end
end
