require_relative "ship"

class Board

attr_reader :ships, :positions

def initialize
	@ships = []
	@positions = []
end

def place_ship(ship, coord)
	fail "Ship overlap" if positions.include?(coord)
	@ships << ship
	@positions << coord
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