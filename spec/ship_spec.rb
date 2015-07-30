require 'ship'

describe Ship do
  it 'has zero hits when created' do
    expect(subject.hits).to eq 0
  end

  it 'will register a hit when hit' do
    subject.register_hit
    expect(subject.hits).to eq 1
  end

  describe '#sunk?' do
    it 'will be sunk when hits == size' do
      size.times { subject.register_hit }
      expect(subject.sunk?).to eq true
    end

    it 'is not sunk on creation' do
      expect(subject.sunk?).to eq false
    end
  end
end
