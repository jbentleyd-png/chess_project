# frozen_string_literal: true

require_relative 'board/board'
require 'colorize'

# the object that stores the status of a given save file and lets players make moves
class Game
  def initialize
    @turn = 'red' # we will do red(white) vs yellow(black) bc we don't know ppl's terminal settings
    @board = Board.new
    @letter_list = %w[A B C D E F G H]
  end

  # INPUT CONVERSION:

  def number_convert(chess_space)
    arr_version = chess_space.chars
    col = @letter_list.index(arr_version[0]) + 1
    arr_version[0] = col
    arr_version[1] = arr_version[1].to_i
    arr_version
  end

  # VALIDATING MOVING PIECE SELECTION:

  def valid_row?(input)
    @letter_list.include?(input[0].upcase)
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

  def move_possible?(piece, target_space)
    piece.potential_moves.include?(target_space.name)

    # now check if there are intervening pieces on the path to the space. depends on piece type.
  end

  def pawn_cannot_attack?(piece, end_space)
    piece.threatening_spaces.include?(end_space.name) && end_space.occupied_by.nil?
    # we check for attacking our own teeam earlier
  end

  def reselect_message(issue) # make it a hash?
    message = case issue
              when 'off_board'
                'on the board.'
              when 'not_your_piece'
                'your own piece.'
              when "can't_move"
                'movable.'
              when 'your_piece'
                'empty or occupied by an enemy piece.'
              when 'impossible_move'
                'a space your piece can reach.'
              when "pawn_can't_attack"
                'occupied by an enemy piece for a pawn attack.'
              end
    print "#{'Coordinate must be '.red}#{message.red}\nEnter: "
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
        reselect_message("can't_move")
        next
      end
      break
    end
    space
  end

  # SELECTING THE SPACE TO MOVE TO:

  def select_end_space(piece)
    end_space = nil
    loop do
      input = gets.chomp.upcase
      unless space_on_board?(input)
        reselect_message('off_board')
        next
      end

      end_space = select_space(input)
      unless move_possible?(piece, end_space)
        reselect_message('impossible_move')
        next
      end
      if piece_on_team?(end_space)
        reselect_message('your_piece')
        next
      end
      # pawn check
      if piece.instance_of?(Pawn) && pawn_cannot_attack?(piece, end_space)
        reselect_message("pawn_can't_attack")
        next
      end

      break
    end
    end_space
  end

  # MAKING A MOVE:
  def turn_message
    first = @turn == 'red' ? "Red's turn. ".red : "Yellow's turn. ".yellow
    "#{first}\nWhich piece would you like to move?\n#{'Select using coordinates (A1, G4, etc.).'.gray}\nSelect piece: "
  end

  def make_move
    @board.render(@turn)
    print turn_message
    start_space = select_start_space
    piece = start_space.occupied_by
    print 'Where would you like to move? '
    end_space = select_end_space(piece)
    @board.update(start_space, piece, end_space)
    @turn = @turn == 'red' ? 'yellow' : 'red'
  end

  def play
    make_move
    6.times do
      make_move
    end
  end
end
