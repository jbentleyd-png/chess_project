# frozen_string_literal: true

require_relative '../../../lib/board/pieces/pawn'
describe Pawn do
  describe 'calc_coordinates' do
    it 'generates 1 coordinate in a central space' do
      test = Pawn.new([99, 99]) # test method directly, not via initialize()
      p test.calc_coordinates([4, 4])
      expect(test.calc_coordinates([4, 4]).length).to eq(1)
    end

    it 'generates 1 coordinates for an edge space' do
      test = Pawn.new([99, 99])
      p test.calc_coordinates([8, 7])
      expect(test.calc_coordinates([8, 7]).length).to eq(1)
    end
  end

  describe 'calc_threatening' do
    it 'generates 2 coordinates in a central space' do
      test = Pawn.new([99, 99]) # test method directly, not via initialize()
      p test.calc_threatening([4, 4])
      expect(test.calc_threatening([4, 4]).length).to eq(2)
    end

    it 'generates 2 coordinates for an edge space' do
      test = Pawn.new([99, 99])
      p test.calc_threatening([8, 7])
      expect(test.calc_threatening([8, 7]).length).to eq(1)
    end
  end
end
