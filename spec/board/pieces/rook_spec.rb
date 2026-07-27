# frozen_string_literal: true

require_relative '../../../lib/board/pieces/rook'
describe Rook do
  describe 'calc_coordinates' do
    it 'generates 14 coordinates in a central space' do
      test = Rook.new([99, 99]) # test method directly, not via initialize()
      p test.calc_coordinates([4, 4])
      expect(test.calc_coordinates([4, 4]).length).to eq(14)
    end

    it 'generates 14 coordinates for a corner space' do
      test = Rook.new([99, 99])
      p test.calc_coordinates([8, 8])
      expect(test.calc_coordinates([8, 8]).length).to eq(14)
    end
  end
end
