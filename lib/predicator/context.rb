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

    def value_for identifier
      name, attr = identifier.split "."
      entity = entities[name]
      if entity.nil?
        raise ArgumentError, "Unknown entity #{name}"
      else
        entity.send attr
      end
    end
  end
end
