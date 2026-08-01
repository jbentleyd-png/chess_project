# frozen_string_literal: true

class Space
  attr_reader :name, :occupied_by

  def initialize(coordinate, oc_by = nil)
    @name = coordinate
    @occupied_by = oc_by
  end

  def render
    if @occupied_by.nil?
      if @name[0].even? && @name[1].even? || @name[0].odd? && @name[1].odd?
        "\u25A0".black
      else
        "\u25A0".gray
      end
    else
      @occupied_by.symbol
    end
  end
end
