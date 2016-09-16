module Predicator
  class PredicateNotFoundError < StandardError
    def initialize name
      super "Could not locate predicate named '#{name}'"
    end
  end

  class MemoryPredicate
    attr_accessor :name, :source, :instructions

    def initialize attributes={}
      @name = attributes[:name]
      @source = attributes[:source]
      @instructions = Predicator.compile @source
    end
  end

  class MemoryRepo
    def initialize
      @store = []
    end

    def size
      @store.size
    end

    def find_by_name name
      pred = @store.detect{|p| p.name == name}
      raise PredicateNotFoundError.new(name) if pred.nil?
      pred
    end

    def create attributes={}
      pred = MemoryPredicate.new attributes
      @store.push pred
      pred
    end
  end
end
