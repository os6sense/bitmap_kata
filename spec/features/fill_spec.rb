
require_relative './feature_helper.rb'

feature 'Fill a region of an image with a new colour' do
  let(:fill) { 'F 3 3 A' }

  before do
    @bitmap = create_5_x_5
  end

  scenario 'When the image is all the default colour' do
    CommandParser.parse(fill).apply(@bitmap)
    expect { @bitmap.show }.to output("AAAAA\n" * 5).to_stdout
  end

  scenario 'When a region of the image is segmented off' do
    @bitmap[0, 1] = Colour.new('B')
    @bitmap[1, 1] = Colour.new('B')
    @bitmap[1, 0] = Colour.new('B')

    CommandParser.parse(fill).apply(@bitmap)

    expect { @bitmap.show }
      .to output("0BAAA\nBBAAA\n" + ("AAAAA\n" * 3)).to_stdout
  end
end
