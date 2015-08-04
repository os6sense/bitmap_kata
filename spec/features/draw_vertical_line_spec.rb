require_relative './feature_helper.rb'

feature 'Draw a vertical segment of colour' do
  let(:plot) { 'V 3 1 5 A' }

  before do
    @bitmap = create_5_x_5
  end

  scenario 'draw line between rows 1 and 5 (inclusive) on column 3.' do
    CommandParser.parse(plot).apply(@bitmap)

    expect { @bitmap.show }
      .to output("00A00\n00A00\n00A00\n00A00\n00A00\n").to_stdout
  end
end
