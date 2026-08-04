# frozen_string_literal: true

# Pawn piece position, possible moves, and threatening spaces
class Pawn
  attr_reader :potential_moves, :threatening_spaces, :team, :symbol, :adjacent_moves, :position

  def calc_coordinates(coordinate)
    possible = []
    direction_value = @team == 'red' ? 1 : -1
    translations = [
      [0, 1 * direction_value], [0, 2 * direction_value],
      [1, 1 * direction_value], [-1, 1 * direction_value]
    ]
    translations.each do |t|
      next_x = coordinate[0] + t[0]
      next_y = coordinate[1] + t[1]
      next if next_x < 1 || next_y < 1 || next_x > 8 || next_y > 8
      # first move:
      next if @team == 'red' && t[1] == 2 && coordinate[1] != 2
      next if @team == 'yellow' && t[1] == 2 && coordinate[1] != 7

      possible << [next_x, next_y]
    end
    possible
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

  def initialize(position, team = 'red')
    @position = position
    @team = team
    @symbol = team == 'red' ? "\u265F".red : "\u265F".yellow
    @potential_moves = calc_coordinates(position)
    @threatening_spaces = calc_threatening(position)
    @adjacent_moves = @potential_moves + @threatening_spaces
  end

  def update_position(new_position)
    @position = new_position
    @potential_moves = calc_coordinates(new_position)
    @threatening_spaces = calc_threatening(new_position)
    @adjacent_moves = @potential_moves + @threatening_spaces
  end
end
