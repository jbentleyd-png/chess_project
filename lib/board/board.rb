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
  def initialize
    @spaces = []
    @white_team = []
    @black_team = []
  end
end
