# frozen_string_literal: true

# Rook piece position, possible moves, and threatening spaces
class Rook
  def calc_coordinates(coordinate) # rubocop:disable Metrics/MethodLength
    possible = []
    positions = [1, 2, 3, 4, 5, 6, 7, 8]
    positions.each do |p|
      vert_x = p
      next_y = coordinate[1]
      possible << [vert_x, next_y] unless [vert_x, next_y] == coordinate

      next_x = coordinate[0]
      hor_y = p
      possible << [next_x, hor_y] unless [next_x, hor_y] == coordinate
    end

    possible
  end

  def initialize(position)
    @position = position
    @potential_moves = calc_coordinates(position)
    @threatening_spaces = @potential_moves
  end
end
