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

      input.value_in self
    end
    alias :[] :value_for
  end
end
