class Ship
  attr_reader :hits, :size

  def initialize(size = 1)
    @hits = 0
    @size = size
  end

  def register_hit
    @hits += 1
  end

  def sunk?
    hits == size
  end

  def self.patrol_boat
    Ship.new(2)
  end

  def self.destroyer
    Ship.new(3)
  end

  def self.submarine
    Ship.new(3)
  end

  def self.battleship
    Ship.new(4)
  end

  def self.aircraft_carrier
    Ship.new(5)
  end

end
