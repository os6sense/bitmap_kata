require_relative './feature_helper.rb'

feature 'user plots a pixel' do
  let(:plot) { 'L 3 3 A' }

  before do
    @bitmap = create_5_x_5
  end

  scenario 'with a bitmap of the default colour' do
    CommandParser.parse(plot).apply(@bitmap)

    expect { @bitmap.show }
      .to output("00000\n00000\n00A00\n00000\n00000\n").to_stdout
  end
end
