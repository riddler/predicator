module Predicator
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
  end
end
