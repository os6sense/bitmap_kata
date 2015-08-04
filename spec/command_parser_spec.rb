require_relative '../lib/command_parser.rb'

describe CommandParser do
  subject { described_class.parse(command) }

  context 'when command is I 20 10' do
    let(:command) { 'I 20 10' }
    it 'set command to create' do
      expect(subject.command).to eq :new
    end

    it 'sets coords to 20 10' do
      expect(subject.coords.x).to eq 20
      expect(subject.coords.y).to eq 10
    end
  end

  context 'when command is C' do
    let(:command) { 'C' }
    it 'set command to clear' do
      expect(subject.command).to eq :clear
    end
  end

  context 'when command is L' do
    let(:command) { 'L 5 6 A' }

    it 'set command to clear' do
      expect(subject.command).to eq :plot
    end
    it 'sets coords to 5 6' do
      expect(subject.coords.x).to eq 5
      expect(subject.coords.y).to eq 6
    end
    it 'sets colour to A' do
      expect(subject.colour.value).to eq 'A'
    end
  end

  context 'when command is V' do
    let(:command) { 'V 3 2 4 A' }

    it 'set command to drawline' do
      expect(subject.command).to eq :drawline
    end
    it 'sets coords to 3 3' do
      pending 'not parsed correctly'
      expect(subject.coords.x).to eq 3
      expect(subject.coords.y).to eq 3
    end
    it 'sets coords2 to 2 4' do
      expect(subject.coords2.x).to eq 2
      expect(subject.coords2.y).to eq 4
    end
    it 'sets colour to A' do
      expect(subject.colour.value).to eq 'A'
    end
  end

  context 'when command is H' do
    let(:command) { 'H 2 4 3 A' }

    it 'set command to drawline' do
      expect(subject.command).to eq :drawline
    end
    it 'sets coords to 2 4' do
      expect(subject.coords.x).to eq 2
      expect(subject.coords.y).to eq 4
    end
    it 'sets coords2 to 2 4' do
      expect(subject.coords2.x).to eq 3
      expect(subject.coords2.y).to eq 3
    end
    it 'sets colour to A' do
      expect(subject.colour.value).to eq 'A'
    end
  end

  context 'when command is F' do
    let(:command) { 'F 2 4 A' }

    it 'set command to fill' do
      expect(subject.command).to eq :fill
    end
    it 'sets coords to 2 4' do
      expect(subject.coords.x).to eq 2
      expect(subject.coords.y).to eq 4
    end
    it 'sets colour to A' do
      expect(subject.colour.value).to eq 'A'
    end
  end

  context 'when command is S' do
    let(:command) { 'S' }

    it 'set command to show' do
      expect(subject.command).to eq :show
    end
  end

  context 'when command is R' do
    let(:command) { 'R' }

    it 'set command to rotate' do
      expect(subject.command).to eq :rotate
    end
  end

  context 'when command is X' do
    let(:command) { 'X' }

    it 'set command to exit' do
      expect(subject.command).to eq :exit
    end
  end
end
