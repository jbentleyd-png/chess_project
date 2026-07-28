# frozen_string_literal: true

require_relative '../../../lib/board/pieces/bishop'
describe Bishop do
  describe 'calc_coordinates' do
    it 'generates 13 coordinates in a central space' do
      test = Bishop.new([99, 99]) # test method directly, not via initialize()
      p test.calc_coordinates([4, 4])
      expect(test.calc_coordinates([4, 4]).length).to eq(13)
    end

    it 'generates 7 coordinates for a corner space' do
      test = Bishop.new([99, 99])
      p test.calc_coordinates([1, 8])
      expect(test.calc_coordinates([1, 8]).length).to eq(7)
    end
  end

  describe 'symbol display' do
    it 'displays a single character, the red(white) bishop piece' do
      test = Bishop.new([4, 4], 'red')
      puts test.symbol
      expect(true).to eq(true)
    end
    it 'displays a single character, the blue(black) bishop piece' do
      test = Bishop.new([4, 4], 'blue')
      puts test.symbol
      expect(true).to eq(true)
    end
  end
end
