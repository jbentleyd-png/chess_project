# frozen_string_literal: true

require_relative 'space'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

class Board
  attr_reader :spaces, :space_coordinates
  attr_accessor :red_team, :yellow_team

  def make_space_coordinates
    spaces = []
    @row_names.each do |c|
      @row_names.each do |r|
        spaces << [r, c]
      end
    end
    spaces
  end

  def populate_red # rubocop:disable Metrics/MethodLength
    @space_coordinates[0..15].map do |c|
      case c
      when [1, 1], [8, 1]
        Rook.new(c)
      when [2, 1], [7, 1]
        Knight.new(c)
      when [3, 1], [6, 1]
        Bishop.new(c)
      when [4, 1]
        Queen.new(c)
      when [5, 1]
        King.new(c)
      else
        Pawn.new(c)
      end
    end
  end

  def populate_yellow # rubocop:disable Metrics/MethodLength
    @space_coordinates[48..63].map do |c|
      case c
      when [1, 8], [8, 8]
        Rook.new(c, 'yellow')
      when [2, 8], [7, 8]
        Knight.new(c, 'yellow')
      when [3, 8], [6, 8]
        Bishop.new(c, 'yellow')
      when [4, 8]
        Queen.new(c, 'yellow')
      when [5, 8]
        King.new(c, 'yellow')
      else
        Pawn.new(c, 'yellow')
      end
    end
  end

  def populate_board
    @space_coordinates.map.with_index do |c, i|
      case i
      when 0..15
        Space.new(c, @red_team[i])
      when 16..47
        Space.new(c)
      when 48..63
        Space.new(c, @yellow_team[i - 48])
      end
    end
  end

  def initialize
    @row_names = [*1..8]
    @col_names = 'A  B  C  D  E  F  G  H'
    @space_coordinates = make_space_coordinates
    @red_team = populate_red # == white
    @yellow_team = populate_yellow # == black
    @spaces = populate_board
  end

  def board_visual(turn) # rubocop:disable Metrics/MethodLength
    row = 8
    low = 56
    high = 64
    label = turn == 'red' ? @col_names : @col_names.reverse
    gray_label = turn == 'red' ? label.gray : "  #{label.gray}"
    output = ["\n", '  ', gray_label, "\n"]

    loop do
      output << row.to_s
      @spaces[low..high].each do |s|
        output << " #{s.render} "
      end
      output << @row_names[row - 1].to_s.gray unless row.zero?
      output << "\n"
      row -= 1
      break if row.zero?

      high = low - 1
      low = high - 7
    end

    output << "  #{label}"
    output << "\n"
    output
  end

  def render(turn)
    if turn == 'red'
      board_visual(turn).each do |string|
        print string
      end
    else
      board_visual(turn).reverse.each do |string|
        print string
      end
    end
  end

  def update(start_space, piece, end_space)
    piece.update_position(end_space.name)
    start_space.occupied_by = nil
    unless end_space.occupied_by.nil?
      dead_piece = end_space.occupied_by
      dead_piece_team = @turn == 'red' ? @board.red_team : @board.yellow_team
      dead_piece_team.delete(dead_piece)
    end
    end_space.occupied_by = piece
  end
end
