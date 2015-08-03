require_relative '../lib/bitmap.rb'

describe Bitmap do
  let(:height) { 4 }
  let(:width)  { 4 }
  let(:default_colour) { double('Colour', value: '0') }
  let(:new_colour) { double('Colour', value: '1') }

  describe '#initialize' do
    subject { described_class.new(height, width, default_colour) }
    it 'returns an instance of the class' do
      expect(subject).to be_a described_class
    end
  end

  describe '.create' do
    subject { described_class.create(height, width, default_colour) }

    it 'creates an array of m elements' do
      expect(subject.size).to eq height
    end

    it 'each sub-element is *width* elements wide' do
      expect(subject.map(&:size).all? { |size| size == width }).to eq true
    end

    it 'populates every element with the default colour' do
      expect(subject.map { |row| row.all? { |e| e == default_colour } }
        .all?).to eq true
    end
  end

  describe '#[]' do
    subject { described_class.new(height, width, default_colour) }
    it 'returns an element' do
      expect(subject[0, 0]).to eq default_colour
    end
  end

  describe '#[]=' do
    subject { described_class.new(height, width, default_colour) }
    before { subject[0, 0] = new_colour }
    it 'sets the element at the specified row and column to val' do
      expect(subject[0, 0]).to eq new_colour
    end
  end

  describe '#clear' do
    subject { described_class.new(height, width, new_colour) }
    it 'resets the value for all Colours' do
      allow(new_colour).to receive(:reset).exactly(height * width).times
      subject.clear
    end
  end

  describe '#drawline' do
    subject { described_class.new(height, width) }
    before { subject.drawline(coord1, coord2, new_colour) }

    context 'when provided coordinates between two columns' do
      let(:coord1) { double('Coord', x: 1, y: 0) }
      let(:coord2) { double('Coord', x: 1, y: 3) }

      it 'draws a horizontal segment of colour between the coords' do
        (coord1.y).upto(coord2.y).each do |y|
          expect(subject[1, y]).to eq new_colour
        end
      end
    end

    context 'when provided coordinates between two rows' do
      let(:coord1) { double('Coord', x: 0, y: 2) }
      let(:coord2) { double('Coord', x: 3, y: 2) }

      it 'draws a horizontal segment of colour between the coords' do
        (coord1.x).upto(coord2.x).each do |x|
          expect(subject[x, 2]).to eq new_colour
        end
      end
    end
  end

  describe '#show' do
    subject { described_class.new(height, width, default_colour) }

    it 'prints out the bitmap' do
      expect{ subject.show }.to output("0000\n" * 4).to_stdout
    end

    context 'when provided the optional named paramter #out' do
      let(:out) { double('StringIO') }
      it 'calls write on the passed object' do
        expect(out).to receive('write')
          .exactly(height + (height * width)).times
        subject.show(out: out)
      end
    end

    context 'when provided the optional name parameter #presenter' do
      let(:presenter) { double('BitmapPresenter') }
      it 'calls the presenters #show method' do
        expect(presenter).to receive('show').exactly(1).times
        subject.show(presenter: presenter)
      end
    end
  end
end
