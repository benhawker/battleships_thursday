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
end
