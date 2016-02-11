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

    def value_for input
      return input unless input.kind_of? Predicator::Variable

      name, attr = input.identifier.split "."
      entity = entities[name]
      if entity.nil?
        raise ArgumentError, "Unknown entity #{name}"
      else
        entity.send attr
      end
    end
  end
end
