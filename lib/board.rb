require_relative 'ship'

class Board
  attr_reader :ships, :positions

  def initialize
    @ships = []
    @positions = {}
  end

  def place_ship(ship, coord, direction)
    all_coords = all_coords(ship.size, coord, direction)
    fail 'Ship overlap' if positions.include?(coord)
    @ships << ship
    @positions << all_coords
  end

  def all_coords(size, coord, direction)
    coords = [coord]
    (size - 1).times do
      if direction == :Vertically
        coords << next_vertical_coord(coords.last)
      elsif direction == :Horizontally
        coords << next_horizontal_coord(coords.last)
      end
    end
    coords
  end

  def next_vertical_coord(coord)
    letter = coord.to_s.scan(/\d+|[A-Z]+/)[0]
    number = coord.to_s.scan(/\d+|[A-Z]+/)[1]
    (letter + number.next).to_sym
  end

  def next_horizontal_coord(coord)
    letter = coord.to_s.scan(/\d+|[A-Z]+/)[0]
    number = coord.to_s.scan(/\d+|[A-Z]+/)[1]
    (letter.next + number).to_sym
  end

  def fire(coord)
    if positions.include?(coord)
      ships.pop.register_hit
      positions.delete(coord)
      :hit
    else
      :miss
    end
  end

  def all_sunk?
    positions.empty?
  end
end


