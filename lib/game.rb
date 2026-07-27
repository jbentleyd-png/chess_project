# frozen_string_literal: true

require_relative 'board/board'

# the object that stores the status of a given save file and lets players make moves
class Game
  def initialize
    @turn = 'white'
    @board = Board.new
  end

  def makeMove
  end
end
