require_relative '../lib/bitmap.rb'

describe Bitmap do
  let(:height) { 4 }
  let(:width)  { 4 }
  let(:dimensions) { double('Coord', x: height, y: width) }
  let(:default_colour) { double('Colour', value: '0') }
  let(:new_colour) { double('Colour', value: '1') }

  describe '#initialize' do
    subject { described_class.new(dimensions, default_colour) }
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
    subject { described_class.new(dimensions, default_colour) }
    it 'returns an element' do
      expect(subject[0, 0]).to eq default_colour
    end
  end

  describe '#[]=' do
    subject { described_class.new(dimensions, default_colour) }
    before { subject[0, 0] = new_colour }
    it 'sets the element at the specified row and column to val' do
      expect(subject[0, 0]).to eq new_colour
    end
  end

  #describe '#at' do
    #it { pending }
  #end

  describe '#clear' do
    subject { described_class.new(dimensions, new_colour) }
    it 'resets the value for all Colours' do
      allow(new_colour).to receive(:reset).exactly(height * width).times
      subject.clear
    end
  end

  describe '#drawline' do
    subject { described_class.new(dimensions) }
    before { subject.drawline(coord1, coord2, new_colour) }

    context 'when provided coordinates between two columns' do
      context 'when the y coordinate is assending' do
        let(:coord1) { double('Coord', x: 2, y: 1, valid?: true) }
        let(:coord2) { double('Coord', x: 2, y: 4, valid?: true) }

        it 'draws a horizontal segment between the coords' do
          (coord1.y).upto(coord2.y).each do |y|
            expect(subject[1, y - 1]).to eq new_colour
          end
        end
      end

      context 'when the y coordinate is descending' do
        let(:coord1) { double('Coord', x: 2, y: 4, valid?: true) }
        let(:coord2) { double('Coord', x: 2, y: 1, valid?: true) }

        it 'draws a horizontal segment between the coords' do
          (coord1.y).upto(coord2.y).each do |y|
            expect(subject[1, y - 1]).to eq new_colour
          end
        end
      end
    end

    context 'when provided coordinates between two rows' do
      context 'then the x coordinate is ascending' do
        let(:coord1) { double('Coord', x: 1, y: 2, valid?: true) }
        let(:coord2) { double('Coord', x: 4, y: 2, valid?: true) }

        it 'draws a horizontal segment between the coords' do
          (coord1.x).upto(coord2.x).each do |x|
            expect(subject[x - 1, 1]).to eq new_colour
          end
        end
      end

      context 'then the x coordinate is decending' do
        let(:coord1) { double('Coord', x: 4, y: 2, valid?: true) }
        let(:coord2) { double('Coord', x: 1, y: 2, valid?: true) }

        it 'draws a horizontal segment between the coords' do
          (coord1.x).upto(coord2.x).each do |x|
            expect(subject[x - 1, 1]).to eq new_colour
          end
        end
      end
    end

    context 'when provided diagonal coordinates between two points' do
      context 'when drawn to the decensing corner' do
        let(:coord1) { double('Coord', x: 1, y: 1, valid?: true) }
        let(:coord2) { double('Coord', x: 4, y: 4, valid?: true) }

        it 'draws a horizontal segment between the coords' do
          (coord1.x).upto(coord2.x).each do |x|
            expect(subject[x - 1, x - 1]).to eq new_colour
          end
        end
      end
    end
  end

  describe '#fill' do
    subject { described_class.new(dimensions, default_colour) }

    let(:coord1) { double('Coord', x: 1, y: 1, valid?: true) }
    let(:a_colour) { double('Colour', value: 'A') }
    let(:b_colour) { double('Colour', value: 'B') }

    it 'fills a bounded region' do
      subject[0, 1] = a_colour
      subject[1, 1] = a_colour
      subject[1, 0] = a_colour

      subject.fill(coord1, new_colour)
      expect { subject.show }
        .to output("1A00\nAA00\n0000\n0000\n").to_stdout
    end

    it 'fills an entire square region' do
      subject.fill(coord1, new_colour)
      expect { subject.show }
        .to output("1111\n" * 4).to_stdout
    end
  end

  describe '#show' do
    subject { described_class.new(dimensions, default_colour) }

    it 'prints out the bitmap' do
      expect { subject.show }.to output("0000\n" * 4).to_stdout
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

  describe '#rotate' do
    subject { described_class.new(dimensions, default_colour) }

    before do
      subject[0, 0] = double('Colour', value: '1')
      subject[0, 3] = double('Colour', value: '2')
      subject[3, 0] = double('Colour', value: '3')
      subject[3, 3] = double('Colour', value: '4')
    end

    it 'rotates the array by 90 degrees clockwise' do
      subject.rotate
      expect { subject.show }
        .to output("3001\n0000\n0000\n4002\n").to_stdout
    end
  end
end
