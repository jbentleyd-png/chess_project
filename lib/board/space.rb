# frozen_string_literal: true

class Space
  def initialize(coordinate, oc_by = nil)
    @name = coordinate
    @occupied_by = oc_by
  end
end
