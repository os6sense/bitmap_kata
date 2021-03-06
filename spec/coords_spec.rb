require_relative '../lib/coord.rb'

describe Coord do
  subject { described_class.new(x, y) }
  let(:y) { 1 }
  let(:x) { 1 }

  describe '#initialize' do
    context 'when x is within the default bounds' do
      it { is_expected.to be_a described_class }
      it 'sets x to the provided value' do
        expect(subject.x).to eq x
      end
    end

    context 'when y is within the default bounds' do
      it { is_expected.to be_a described_class }
      it 'sets y to the provided value' do
        expect(subject.y).to eq y
      end
    end

    context 'when both are in valid bounds' do
      it 'sets valid? to true' do
        expect(subject.valid?).to eq true
      end
    end

    context 'when x is below the default bound' do
      let(:x) { 0 }
      it 'sets valid? to false' do
        expect(subject.valid?).to eq false
      end
    end

    context 'when x is above the default bound' do
      let(:x) { 251  }
      it 'sets valid? to false' do
        expect(subject.valid?).to eq false
      end
    end

    context 'when y is below the default bound' do
      let(:y) { 0 }
      it 'sets valid? to false' do
        expect(subject.valid?).to eq false
      end
    end

    context 'when y is above the default bound' do
      let(:y) { 251  }
      it 'sets valid? to false' do
        expect(subject.valid?).to eq false
      end
    end
  end

  describe '#x' do
    subject { described_class.new(x, y).x }
    it { is_expected.to eq x }
  end

  describe '#y' do
    subject { described_class.new(x, y).y }
    it { is_expected.to eq y }
  end

  describe '#y=' do
    let(:new_y) { 20 }
    it 'sets y to the provided value' do
      expect(subject.y).not_to eq new_y # sanity check

      subject.y = y
      expect(subject.y).to eq y
    end
  end

  describe '#x=' do
    let(:new_x) { 20 }
    it 'sets x to the provided value' do
      expect(subject.x).not_to eq new_x # sanity check

      subject.x = x
      expect(subject.x).to eq x
    end
  end
end
