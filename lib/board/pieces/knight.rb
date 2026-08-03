# frozen_string_literal: true

# Knight piece position, possible moves, and threatening spaces
class Knight
  attr_reader :potential_moves, :threatening_spaces, :team, :symbol, :adjacent_moves

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

  def initialize(position, team = 'red')
    @position = position
    @team = team
    @symbol = team == 'red' ? "\u265E".red : "\u265E".yellow
    @potential_moves = calc_coordinates(position)
    @adjacent_moves = @potential_moves
    @threatening_spaces = @potential_moves
  end

  def update_position(new_position)
    @position = new_position
    @potential_moves = calc_coordinates(new_position)
    @adjacent_moves = @potential_moves
    @threatening_spaces = @potent
  end
end
