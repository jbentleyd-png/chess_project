# frozen_string_literal: true

require_relative '../../../lib/board/pieces/knight'
describe Knight do
  describe 'calc_coordinates' do
    it 'generates 8 coordinates in a central space' do
      test = Knight.new([99, 99]) # test method directly, not via initialize()
      p test.calc_coordinates([4, 4])
      expect(test.calc_coordinates([4, 4]).length).to eq(8)
    end

    it 'generates 2 coordinates for a corner space' do
      test = Knight.new([99, 99])
      p test.calc_coordinates([1, 1])
      expect(test.calc_coordinates([1, 1]).length).to eq(2)
    end
  end
end
