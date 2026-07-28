# frozen_string_literal: true

require_relative 'space'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/piece'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

class Board
  def space_coordinates
    spaces = []
    files = [*1..8]
    files.each do |c|
      files.each do |r|
        spaces << [r, c]
      end
    end
    spaces
  end

  def populate_red
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

  def populate_blue
    @space_coordinates[48..63].map do |c|
      case c
      when [1, 8], [8, 8]
        Rook.new(c, 'blue')
      when [2, 8], [7, 8]
        Knight.new(c, 'blue')
      when [3, 8], [6, 8]
        Bishop.new(c, 'blue')
      when [4, 8]
        Queen.new(c, 'blue')
      when [5, 8]
        King.new(c, 'blue')
      else
        Pawn.new(c, 'blue')
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
        Space.new(c, @blue_team[i - 48])
      end
    end
  end

  def initialize
    @space_coordinates = space_coordinates
    @red_team = populate_red # == white
    @blue_team = populate_blue # == black
    @spaces = populate_board
  end
end
