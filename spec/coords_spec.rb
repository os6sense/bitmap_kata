
require_relative '../lib/coord.rb'

describe Coord do
  subject { described_class.new(x, y) }
  describe '#initialize' do
    let(:y) { 0 }
    let(:x) { 0 }

    context 'when x is within the default bounds' do
      it { is_expected.to be_a described_class }
      it 'sets x to the provided value' do
        expect(subject.x).to eq 0
      end
    end

    context 'when y is within the default bounds' do
      it { is_expected.to be_a described_class }
      it 'sets y to the provided value' do
        expect(subject.y).to eq 0
      end
    end

    context 'when x is below the default bound' do
      let(:x) { -100 }
      it 'raises an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'when x is above the default bound' do
      let(:x) { 1000  }
      it 'raises an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'when y is below the default bound' do
      let(:y) { -100 }
      it 'raises an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'when y is above the default bound' do
      let(:y) { 1000  }
      it 'raises an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end
end
