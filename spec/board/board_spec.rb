# frozen_string_literal: true

require_relative '../../lib/board/board'
describe Board do
  describe 'space_coordinates' do
    xit 'creates 64 coordinates' do
      test = Board.new
      sc = test.space_coordinates
      p sc
      puts 'First 16:'
      p sc[0..15]
      expect(sc.length).to eq(64)
    end

    xit '7th space is [7, 1]' do
      test = Board.new
      sc = test.space_coordinates
      expect(sc[6]).to eq([7, 1])
    end
  end

  describe 'populate_red' do
    xit 'creates 16 pieces' do
      test = Board.new
      pr = test.populate_red
      expect(pr.length).to eq(16)
    end

    xit 'third piece is a bishop' do
      test = Board.new
      pr = test.populate_red
      expect(pr[2]).to be_a(Bishop)
    end
  end

  describe 'populate_yellow' do
    xit 'creates 16 pieces' do
      test = Board.new
      pb = test.populate_yellow
      expect(pb.length).to eq(16)
    end

    xit '11th piece is a bishop' do
      test = Board.new
      pb = test.populate_yellow
      expect(pb[10]).to be_a(Bishop)
    end
  end

  describe 'populate_board' do
    xit 'final Space is occupied by a Rook' do
      test = Board.new
      pb = test.populate_board
      expect(pb[-1].occupied_by).to be_a(Rook)
    end

    xit '[4,4] is empty' do
      test = Board.new
      pb = test.populate_board
      four_four_index = pb.find_index { |space| space.name == [4, 4] }
      p four_four_index

      expect(pb[four_four_index].occupied_by).to eq(nil)
    end

    xit '[2,8] has a knight on it' do
      test = Board.new
      pb = test.populate_board
      four_four_index = pb.find_index { |space| space.name == [2, 8] }
      p four_four_index

      expect(pb[four_four_index].occupied_by).to be_a(Knight)
    end
  end

  describe 'render' do
    it 'prints the red-side board well' do
      test = Board.new

      puts 'THIS IS THE DATA PRINTED IN ORDER:'
      test.spaces.each do |s|
        print s.render
      end
      puts "\n"

      puts 'THIS IS THE REAL LIFE:'
      test.render('red')

      expect(true).to be(true)
    end

    xit 'prints the yellow-side board well' do
      test = Board.new
      test.render('yellow')

      expect(true).to be(true)
    end
  end
end
