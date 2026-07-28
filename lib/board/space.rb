# frozen_string_literal: true

class Space
  attr_reader :name, :occupied_by

  def initialize(coordinate, oc_by = nil)
    @name = coordinate
    @occupied_by = oc_by
  end
end
