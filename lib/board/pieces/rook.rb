# frozen_string_literal: true

# Rook piece position, possible moves, and threatening spaces
class Rook
  attr_reader :potential_moves, :threatening_spaces, :team, :symbol, :adjacent_moves, :position

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

  def calc_adjacent(coordinate)
    adjacent = []
    translations = [[0, 1], [0, -1], [-1, 0], [1, 0]]

    translations.each do |t|
      next_x = coordinate[0] + t[0]
      next_y = coordinate[1] + t[1]
      next if next_x < 1 || next_y < 1 || next_x > 8 || next_y > 8

      adjacent << [next_x, next_y]
    end
    adjacent
  end

  def initialize(position, team = 'red')
    @position = position
    @team = team
    @symbol = team == 'red' ? "\u265C".red : "\u265C".yellow
    @potential_moves = calc_coordinates(position)
    @adjacent_moves = calc_adjacent(position)
    @threatening_spaces = @potential_moves
  end

  def update_position(new_position)
    @position = new_position
    @potential_moves = calc_coordinates(new_position)
    @adjacent_moves = calc_adjacent(new_position)
    @threatening_spaces = @potential_moves
  end
end
