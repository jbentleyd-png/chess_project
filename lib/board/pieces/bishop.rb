# frozen_string_literal: true

# Bishop piece position, possible moves, and threatening spaces
class Bishop
  def calc_coordinates(coordinate) # rubocop:disable Metrics/MethodLength
    possible = []
    outward_expansion = [1, 2, 3, 4, 5, 6, 7]
    translations = [
      [1, 1], [-1, 1], [1, -1], [-1, -1]
    ]
    outward_expansion.each do |oe|
      translations.each do |t|
        next_x = coordinate[0] + t[0] * oe
        next_y = coordinate[1] + t[1] * oe
        next if next_x < 1 || next_y < 1 || next_x > 8 || next_y > 8

        possible << [next_x, next_y]
      end
    end

    possible
  end

  def initialize(position)
    @position = position
    @potential_moves = calc_coordinates(position)
    @threatening_spaces = @potential_moves
  end
end
