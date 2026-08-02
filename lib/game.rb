# frozen_string_literal: true

require_relative 'board/board'
require 'colorize'

# the object that stores the status of a given save file and lets players make moves
class Game
  def initialize
    @turn = 'red' # we will do red(white) vs yellow(black) bc we don't know ppl's terminal settings
    @board = Board.new
  end

  # INPUT CONVERSION:
  def letter_convert(coordinate)
    output = ''
    letter_list = %w[A B C D E F G H]
    output += letter_list[coordinate[0] - 1]
    output += coordinate[1].to_s
    output
  end

  def valid_row?(letter)
    %w[A B C D E F G H].include?(letter[0].upcase)
  end

  def number_convert(chess_space)
    return 'invalid row' unless valid_row?(chess_space)

    letter_list = %w[A B C D E F G H]
    arr_version = chess_space.chars
    col = letter_list.index(arr_version[0]) + 1
    arr_version[0] = col
    arr_version[1] = arr_version[1].to_i
    arr_version
  end

  # SLECTING THE PIECE:
  def turn_message
    first = @turn == 'red' ? "Red's turn. ".red : "Yellow's turn. ".yellow
    "#{first}\nWhich piece would you like to move?\n#{'Select using coordinates (A1, G4, etc.).'.gray}\nEnter: "
  end

  def piece_on_team?(piece_coordinate)
    space = @board.spaces.find { |s| s.name == piece_coordinate }
    return false if space.occupied_by.nil?

    space.occupied_by.team == @turn
  end

  def piece_can_move?(piece_coordinate) # this one requires some data fixes
    space = @board.spaces.find { |s| s.name == piece_coordinate }
    piece = space.occupied_by
    piece.potential_moves.include?(piece_coordinate)
  end

  def reselect_piece
    puts 'Enter a valid coordinate.'.red
    puts 'Coordinate must be on the board and your own piece, which can move.'.gray
    print 'Enter: '
    number_convert(gets.chomp.upcase)
  end

  def select_piece
    # player_team = @turn == 'red' ? @baord.red_team : @board.blue_team
    piece_coordinate = number_convert(gets.chomp.upcase)
    until @board.space_coordinates.include?(piece_coordinate) && piece_on_team?(piece_coordinate) # && piece_can_move?(piece_coordinate)
      piece_coordinate = reselect_piece
    end
  end

  # MAKING A MOVE:
  def make_move
    @board.render(@turn)
    print turn_message
    piece = select_piece
  end

  def play
    make_move
  end
end
