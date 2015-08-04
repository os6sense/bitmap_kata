require_relative './feature_helper.rb'

feature 'user creates new image' do
  let(:create) { 'I 20 10' }

  scenario 'with a valid height and width' do
    cmd = CommandParser.parse(create)
    @bitmap = cmd.apply(Bitmap)
    expect { @bitmap.show }
      .to output("#{'0' * 20}\n" * 10).to_stdout
  end
end
