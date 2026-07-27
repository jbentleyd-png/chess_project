# frozen_string_literal: true

# Knight piece position, possible moves, and threatening spaces
class Knight
  def calc_coordinates(coordinate) # rubocop:disable Metrics/MethodLength
    possible = []
    translations = [
      [2, 1], [2, -1],
      [-2, 1], [-2, -1],
      [1, 2], [1, -2],
      [-1, 2], [-1, -2]
    ]
    translations.each do |t|
      next_x = coordinate[0] + t[0]
      next_y = coordinate[1] + t[1]
      next if next_x < 1 || next_y < 1 || next_x > 8 || next_y > 8

      # check if these spaces are actually occupied in an outside scope

      possible << [next_x, next_y]
    end
    possible
  end

  def initialize(position)
    @position = position
    @potential_moves = calc_coordinates(position)
    @threatening_spaces = @potential_moves
  end
end
