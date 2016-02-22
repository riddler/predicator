module Predicator
  class Variable
    attr_reader :entity, :attribute

    def initialize entity, attribute
      @entity = entity
      @attribute = attribute
    end

    def == other
      other.kind_of?(self.class) &&
        other.entity == entity &&
        other.attribute == attribute
    end
  end
end
