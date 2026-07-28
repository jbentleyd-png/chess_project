# frozen_string_literal: true

require_relative '../../lib/board/board'
describe Board do
  describe 'space_coordinates' do
    it 'creates 64 coordinates' do
      test = Board.new
      sc = test.space_coordinates
      p sc
      puts 'First 16:'
      p sc[0..15]
      expect(sc.length).to eq(64)
    end

    it '7th space is [7, 1]' do
      test = Board.new
      sc = test.space_coordinates
      expect(sc[6]).to eq([7, 1])
    end
  end

  describe 'populate_red' do
    it 'creates 16 pieces' do
      test = Board.new
      pr = test.populate_red
      expect(pr.length).to eq(16)
    end

    it 'third piece is a bishop' do
      test = Board.new
      pr = test.populate_red
      expect(pr[2]).to be_a(Bishop)
    end
  end

  describe 'populate_blue' do
    it 'creates 16 pieces' do
      test = Board.new
      pb = test.populate_blue
      expect(pb.length).to eq(16)
    end

    it '11th piece is a bishop' do
      test = Board.new
      pb = test.populate_blue
      expect(pb[10]).to be_a(Bishop)
    end
  end

  describe 'populate_board' do
    it 'final Space is occupied by a Rook' do
      test = Board.new
      pb = test.populate_board
      expect(pb[-1].occupied_by).to be_a(Rook)
    end

    it '[4,4] is empty' do
      test = Board.new
      pb = test.populate_board
      four_four_index = pb.find_index { |space| space.name == [4, 4] }
      p four_four_index

      expect(pb[four_four_index].occupied_by).to eq(nil)
    end

    it '[2,8] has a knight on it' do
      test = Board.new
      pb = test.populate_board
      four_four_index = pb.find_index { |space| space.name == [2, 8] }
      p four_four_index

      expect(pb[four_four_index].occupied_by).to be_a(Knight)
    end
  end
end
