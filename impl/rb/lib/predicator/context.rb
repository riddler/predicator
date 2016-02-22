require "ostruct"

module Predicator
  class Context
    attr_reader :entities

    def initialize
      @entities = {}
    end

    def bind name, value
      value = OpenStruct.new(value) if value.kind_of? Hash
      entities[name.to_s] = value
    end
    alias :[]= :bind

    def value_for input
      return input unless input.kind_of? Predicator::Variable

      entity_name = input.entity.to_s
      entity = entities[entity_name]
      if entity.nil?
        raise ArgumentError, "Unknown entity #{entity_name}"
      else
        entity.send input.attribute
      end
    end
    alias :[] :value_for
  end
end
