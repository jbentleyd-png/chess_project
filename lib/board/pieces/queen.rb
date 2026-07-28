# frozen_string_literal: true

# Queen piece position, possible moves, and threatening spaces
class Queen
  attr_reader :potential_moves, :threatening_spaces

  def bishop_style_coordinates(coordinate) # rubocop:disable Metrics/MethodLength
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

  def rook_style_coordinates(coordinate) # rubocop:disable Metrics/MethodLength
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

  def calc_coordinates(position)
    bishop_style_coordinates(position) + rook_style_coordinates(position)
  end

  def initialize(position)
    @position = position
    @potential_moves = calc_coordinates(position)
    @threatening_spaces = @potential_moves
  end

  # we check if the move is possible elsewhere, this simply updates the object's data
  def update_position(new_position)
    @position = new_position
    @potential_moves = calc_coordinates(new_position)
    @threatening_spaces = @potential_moves
  end
end
