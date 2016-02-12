module Predicator
  class Variable
    attr_reader :identifier

    def initialize identifier
      @identifier = identifier
    end

    def == other
      other.kind_of?(self.class) &&
        other.identifier == identifier
    end
  end
end
