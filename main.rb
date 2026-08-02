# frozen_string_literal: true

require_relative 'lib/game'

def load_game
  puts 'Load Game function'
end

def new_game
  puts 'New Game function'
  game = Game.new
  game.play
end

def choose_mode
  game_mode = gets.chomp.upcase
  until %w[L N].include?(game_mode)
    puts 'Enter either "L"(load) or "N"(new).'.red
    print 'Enter: '
    game_mode = gets.chomp.upcase
  end
end

def opening_sequence
  puts "\n\n*******************RUBY CHESS*******************".yellow
  puts "\nNew Game (N) or Load Game(L)?"
  print 'Enter: '
  game_mode = choose_mode
  if game_mode == 'L'
    load_game
  else
    new_game
  end
end

opening_sequence
