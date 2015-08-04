require_relative './feature_helper.rb'

feature 'Draw a horizonal degment of colour' do
  let(:plot) { 'H 1 5 3 A' }

  before do
    @bitmap = create_5_x_5
  end

  scenario 'draw line on row 3 between columns 1 and 5 (inclusive).' do
    CommandParser.parse(plot).apply(@bitmap)

    expect { @bitmap.show }
      .to output("00000\n00000\nAAAAA\n00000\n00000\n").to_stdout
  end
end
