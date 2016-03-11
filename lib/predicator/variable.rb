module Predicator
  class Variable
    attr_reader :model, :attribute

    def initialize model, attribute
      @model = model
      @attribute = attribute
    end

    def value_in context
      entity_name = model.to_s
      entity = context.bindings[model]
      if entity.nil?
        raise ArgumentError, "Unknown entity #{entity_name}"
      else
        entity.send attribute
      end
    end

    def == other
      other.kind_of?(self.class) &&
        other.model == model &&
        other.attribute == attribute
    end
  end
end
