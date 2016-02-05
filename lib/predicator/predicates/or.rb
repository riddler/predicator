module Predicator::Predicates
  class Or
    attr_reader :predicates

    def initialize predicates
      @predicates = predicates
    end

    def == other
      other.kind_of?(self.class) &&
        other.predicates == predicates
    end
  end
end
