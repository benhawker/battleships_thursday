require_relative 'ship'

class Board
  attr_reader :ships, :positions, :hits, :misses

  def initialize
    @ships = []
    @positions = {}
    @hits = []
    @misses = []
  end

  def place_ship(ship, coord, direction)
    all_coords = all_coords(ship.size, coord, direction)
    fail 'Ship overlap' unless (ships & all_coords).empty?
    fail 'Outside accepted coords' if off_board?(all_coords)
    @ships += all_coords
    all_coords.each { |coordinate| @positions[coordinate] = ship }
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
    if ships.include?(coord)
      positions[coord].register_hit
      ships.delete(coord)
      log_hits(coord)
    else
      log_misses(coord)
    end
  end

  def all_sunk?
    ships.empty?
  end

  def off_board?(all_coords)
    letters = []
    numbers = []

    all_coords.each do |coord| 
      letters << coord.to_s.scan(/\d+|[A-Z]+/)[0]
      numbers << coord.to_s.scan(/\d+|[A-Z]+/)[1]
    end

    letters.any? { |letter| letter.ord - 64 > 10 } || numbers.any? { |number| number.to_i > 10 }
  end

  def log_hits(coord)
    @hits << coord
    :hit
  end

  def log_misses(coord)
    fail "You have already missed that spot" if misses.include?(coord)
    fail "You have already hit that spot" if hits.include?(coord)
    @misses << coord
    :miss
  end

end


