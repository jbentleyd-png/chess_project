# frozen_string_literal: true

require_relative '../../../lib/board/pieces/queen'
describe Queen do
  describe 'calc_coordinates' do
    it 'generates 27 coordinates in a central space' do
      test = Queen.new([99, 99]) # test method directly, not via initialize()
      p test.calc_coordinates([4, 4])
      expect(test.calc_coordinates([4, 4]).length).to eq(27)
    end

    it 'generates 21 coordinates for a corner space' do
      test = Queen.new([99, 99])
      p test.calc_coordinates([1, 1])
      expect(test.calc_coordinates([1, 1]).length).to eq(21)
    end
  end
end
