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

  def number_convert(chess_space)
    letter_list = %w[A B C D E F G H]
    arr_version = chess_space.chars
    col = letter_list.index(arr_version[0]) + 1
    arr_version[0] = col
    arr_version[1] = arr_version[1].to_i
    arr_version
  end

  # VALIDATING MOVING PIECE SELECTION:

  def valid_row?(input)
    %w[A B C D E F G H].include?(input[0].upcase)
  end

  def space_on_board?(input)
    return false unless valid_row?(input)

    @board.space_coordinates.include?(number_convert(input))
  end

  def piece_on_team?(space)
    return false if space.occupied_by.nil?

    space.occupied_by.team == @turn
  end

  def piece_can_move?(space)
    piece = space.occupied_by
    total_adj_moves = piece.adjacent_moves.length
    blocked = 0
    piece.adjacent_moves.each do |space_coordinate|
      adj_space = @board.spaces.find { |s| s.name == space_coordinate }
      blocked += 1 unless adj_space.occupied_by.nil? || adj_space.occupied_by.team != @turn
    end
    blocked < total_adj_moves
  end

  def reselect_message(issue)
    message = case issue
              when 'off_board'
                'on the board.'
              when 'not_your_piece'
                'your own piece.'
              else
                'movable.'
              end
    puts 'Enter a valid coordinate.'.red
    print "#{'Coordinate must be '.gray}#{message.gray}\nEnter: "
  end

  # SELECTING THE PIECE TO MOVE:

  def select_space(input)
    piece_coordinate = number_convert(input)
    @board.spaces.find { |s| s.name == piece_coordinate } # returns nil if nothing is found
  end

  def select_start_space
    space = nil
    loop do
      input = gets.chomp.upcase
      unless space_on_board?(input)
        reselect_message('off_board')
        next
      end

      space = select_space(input)
      unless piece_on_team?(space)
        reselect_message('not_your_piece')
        next
      end
      unless piece_can_move?(space)
        reselect_message("can't move")
        next
      end
      break
    end
    space
  end

  # MAKING A MOVE:
  def turn_message
    first = @turn == 'red' ? "Red's turn. ".red : "Yellow's turn. ".yellow
    "#{first}\nWhich piece would you like to move?\n#{'Select using coordinates (A1, G4, etc.).'.gray}\nEnter: "
  end

  def make_move
    @board.render(@turn)
    print turn_message
    start_space = select_start_space
    piece = start_space.occupied_by
    p piece
  end

  def play
    make_move
  end
end
