require_relative './feature_helper.rb'

feature 'user wants to exit' do
  let(:exit) { 'X' }

  scenario 'an exit command is given' do
    cmd = CommandParser.parse(exit)

    expect { cmd.apply(Bitmap) }.to raise_error SystemExit
  end
end
