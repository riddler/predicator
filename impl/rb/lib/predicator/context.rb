require "ostruct"

module Predicator
  class Context
    attr_reader :bindings

    def initialize
      @bindings = {}
    end

    def bind name, value
      value = OpenStruct.new(value) if value.kind_of? Hash
      bindings[name.to_s] = value
    end

    def value_for input
      return input unless input.kind_of? Predicator::Variable

      input.value_in self
    end
    alias :[] :value_for
  end
end
