require 'board'

describe Board do
  let(:ship) { double :ship }
  before(:each) { allow(ship).to receive :register_hit }


  context 'ships of size 1' do
    before(:each) { allow(ship).to receive(:size) { 1 } }
    describe '#place_ship' do
      it 'receives a ship' do
        subject.place_ship(ship, :A1, :Vertically)
        expect(subject.ships).to eq [:A1]
      end

      it 'places the ship on specific coord' do
        subject.place_ship(ship, :A1, :Vertically)
        expect(subject.positions[:A1]).to eq ship
      end

      it 'does not allow ships to overlap' do
        subject.place_ship(ship, :A1, :Vertically)
        expect { subject.place_ship(ship, :A1, :Vertically) }.to raise_error 'Ship overlap'
      end
    end
  end


   context 'ships of size 2' do
    before(:each) { allow(ship).to receive(:size) { 2 } }
    describe '#place_ship' do
      it 'receives a ship' do
        subject.place_ship(ship, :A1, :Vertically)
        expect(subject.ships).to eq [ship]
      end

      it 'places the ship on specific coord' do
        subject.place_ship(ship, :A1, :Vertically)
        expect(subject.positions).to eq [:A1, :A2]
      end

      it 'places the ship on specific coord' do
        subject.place_ship(ship, :A1, :Horizontally)
        expect(subject.positions).to eq [:A1, :B1]
      end

      it 'does not allow ships to overlap' do
        subject.place_ship(ship, :B1, :Horizontally)
        expect { subject.place_ship(ship, :A2, :Vertically) }.to raise_error 'Ship overlap'
      end
    end
  end

  describe '#fire' do
    it 'should return hit if it hits' do
      subject.place_ship(ship, :A1, :Vertically)
      expect(subject.fire(:A1)).to eq :hit
    end

    it 'should return miss if it misses' do
      subject.place_ship(ship, :A1, :Vertically)
      expect(subject.fire(:D3)).to eq :miss
    end

    it 'the ship will recieve register_hit when it is hit' do
      subject.place_ship(ship, :A1, :Vertically)
      expect(ship).to receive :register_hit
      subject.fire(:A1)
    end

    it 'the ship will not receive register_hit when it is missed' do
      subject.place_ship(ship, :A1, :Horizontally)
      expect(ship).to_not receive :register_hit
      subject.fire(:A2)
    end
  end

  describe '#all_sunk' do
    it 'should return true when ships are all sunk' do
      subject.place_ship(ship, :A1, :Vertically)
      subject.fire(:A1)
      expect(subject.all_sunk?).to eq true
    end

    it 'should return false when ships are not all sunk' do
      subject.place_ship(ship, :A1, :Vertically)
      subject.place_ship(ship, :B1, :Vertically)
      subject.fire(:A1)
      expect(subject.all_sunk?).to eq false
    end
  end
end
