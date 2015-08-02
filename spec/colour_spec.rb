require_relative '../lib/colour.rb'

describe Colour do
  subject { described_class.new }
  describe '#initialize' do
    context 'when initialized without parameters' do
      it 'sets the #value to Colour::DEFAULT' do
        expect(subject.value).to eq Colour::DEFAULT
      end
    end

    context 'when provided a parameter ' do
      let(:colour) { '1' }
      subject { described_class.new(colour) }

      it 'sets the value to that supplied' do
        expect(subject.value).to eq colour
      end
    end
  end

  describe '#reset' do
    let(:colour) { '1' }
    subject { described_class.new(colour) }

    before { subject.reset }
    it 'resets the value to Colour::Default' do
      expect(subject.value).to eq Colour::DEFAULT
    end
  end

  describe '#value' do
    let(:colour) { '1' }
    subject { described_class.new(colour).value }
    it { is_expected.to eq colour }
  end

  describe '#value=' do
    let(:colour) { '2' }
    before { subject.value = colour }
    it 'sets the value' do
      expect(subject.value).to eq colour
    end
  end
end
