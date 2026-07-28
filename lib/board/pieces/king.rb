# frozen_string_literal: true

# King piece position, possible moves, and threatening spaces
class King
  attr_reader :potential_moves, :threatening_spaces

  def calc_coordinates(coordinate) # rubocop:disable Metrics/MethodLength
    possible = []
    translations = [
      [1, 0], [-1, 0],
      [0, 1], [0, -1],
      [1, 1], [-1, 1],
      [1, -1], [-1, -1]
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

  def initialize(position, team)
    @position = position
    @team = team
    @potential_moves = calc_coordinates(position)
    @threatening_spaces = @potential_moves
  end

  def update_position(new_position)
    @position = new_position
    @potential_moves = calc_coordinates(new_position)
    @threatening_spaces = @potential_moves
  end
end
