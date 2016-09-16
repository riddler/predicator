module Predicator
  class UndefinedVariableError < ArgumentError; end

  class Context
    def initialize params={}
      @bindings = {}
      params.each{ |key,value| bind key, value }
    end

    def bind name, value
      @bindings[name.to_s] = value
    end
    alias :[]= :bind

    def binding_for name
      @bindings[name.to_s]
    end
    alias :[] :binding_for

    def value_of input
      if input.kind_of? Variable
        value_of_variable input
      else
        input
      end
    end

    def value_of_variable input
      if !@bindings.key? input.name
        raise UndefinedVariableError
      else
        @bindings[input.name]
      end
    end
  end
end
