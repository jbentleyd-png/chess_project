# frozen_string_literal: true

require_relative 'board/board'
require 'colorize'

# the object that stores the status of a given save file and lets players make moves
class Game
  def initialize
    @turn = 'red' # we will do red(white) vs yellow(black) bc we don't know ppl's terminal settings
    @board = Board.new
    @letter_list = %w[A B C D E F G H]
    @message = {
      'off_board' => 'on the board.',
      'not_your_piece' => 'your own piece.',
      "can't_move" => 'movable.',
      'your_piece' => 'empty or occupied by an enemy piece.',
      'impossible_move' => 'a space your piece can reach.',
      "pawn_can't_attack" => 'occupied by an enemy piece for a pawn attack.',
      'lane_blocked' => 'accessible by non-teleport means.'
    }
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

  # VALIDATING IF THE PIECE CAN MOVE TO SELECTED SPACE:

  def move_possible?(piece, end_space)
    piece.potential_moves.include?(end_space.name)
  end

  def pawn_cannot_attack?(piece, end_space)
    piece.threatening_spaces.include?(end_space.name) && end_space.occupied_by.nil?
    # we check for attacking our own teeam earlier
  end

  def ranged_attack?(piece, end_space)
    return false unless piece.instance_of?(Rook) || piece.instance_of?(Bishop) || piece.instance_of?(Queen)

    return false if (piece.position[0] - end_space.name[0]).abs < 2 && (piece.position[1] - end_space.name[1]).abs < 2

    true
  end

  def attack_direction(piece, end_space)
    end_x = end_space.name[0]
    end_y = end_space.name[1]

    if end_y > piece.position[1]
      return 'UR' if end_x > piece.position[0]
      return 'UL' if end_x < piece.position[0]

      return 'U'
    elsif end_y < piece.position[1]
      return 'DR' if end_x > piece.position[0]
      return 'DL' if end_x < piece.position[0]

      return 'D'
    elsif end_y == piece.position[1]
      return 'R' if end_x > piece.position[0]
    end
    'L'
  end

  def lane_search(current_coordinate, end_space, movement)
    loop do
      current_coordinate[0] += movement[0]
      current_coordinate[1] += movement[1]
      p "current_coordinate : #{current_coordinate}"
      current_space = @board.spaces.find { |s| s.name == current_coordinate }
      p current_space.occupied_by
      break if current_space == end_space
      return true unless current_space.occupied_by.nil?
    end
    false
  end

  def bishop_blocked?(piece, end_space, direction)
    directions = %w[UR UL DR DL]
    translations = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    movement = translations[directions.index(direction)]
    p "movement : #{movement}"
    current_coordinate = piece.position.dup # so we don't mutate the position of the object
    p "current_coordinate : #{current_coordinate}"
    lane_search(current_coordinate, end_space, movement)
  end

  def rook_blocked?(piece, end_space, direction)
    directions = %w[U D R L]
    translations = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    movement = translations[directions.index(direction)]
    current_coordinate = piece.position.dup # so we don't mutate the position of the object
    lane_search(current_coordinate, end_space, movement)
  end

  def lane_blocked?(piece, end_space)
    direction = attack_direction(piece, end_space)
    if direction.length == 2
      p 'bishop life'
      bishop_blocked?(piece, end_space, direction)
    else
      p 'rook life'
      rook_blocked?(piece, end_space, direction)
    end
  end

  # TELL THE USER ABOUT AN INVALID SELECTION:

  def reselect_message(issue)
    message = @message[issue]
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

      puts "ranged attack: #{ranged_attack?(piece, end_space)}"
      puts "lane blocked: #{lane_blocked?(piece, end_space)}"
      if ranged_attack?(piece, end_space) && lane_blocked?(piece, end_space)
        reselect_message('lane_blocked')
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
    69.times do
      make_move
    end
  end
end
