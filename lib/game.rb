# frozen_string_literal: true

require_relative 'board/board'

# the object that stores the status of a given save file and lets players make moves
class Game
  def initialize
    @turn = 'red' # we will do red(white) vs blue(black) bc we don't know ppl's terminal settings
    @board = Board.new
  end

  def makeMove
  end
end
