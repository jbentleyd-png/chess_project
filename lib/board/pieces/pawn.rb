# frozen_string_literal: true

# Pawn piece position, possible moves, and threatening spaces
class Pawn
  attr_reader :potential_moves, :threatening_spaces

  def calc_coordinates(coordinate)
    next_x = coordinate[0] + 0
    next_y = coordinate[1] + 1
    return [] if next_x < 1 || next_y < 1 || next_x > 8 || next_y > 8

    [[next_x, next_y]]
  end

  def calc_threatening(coordinate)
    possible = []
    translations = [[1, 1], [-1, 1]]
    translations.each do |t|
      next_x = coordinate[0] + t[0]
      next_y = coordinate[1] + t[1]
      next if next_x < 1 || next_y < 1 || next_x > 8 || next_y > 8

      possible << [next_x, next_y]
    end
    possible
  end

  def initialize(position, team)
    @position = position
    @team = team
    @potential_moves = calc_coordinates(position)
    @threatening_spaces = calc_threatening(position)
  end

  def update_position(new_position)
    @position = new_position
    @potential_moves = calc_coordinates(new_position)
    @threatening_spaces = calc_threatening(new_position)
  end
end
