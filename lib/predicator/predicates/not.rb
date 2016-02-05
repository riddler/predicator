module Predicator::Predicates
  class Not
    attr_reader :predicate

    def initialize predicate
      @predicate = predicate
    end

    def == other
      other.kind_of?(self.class) && other.predicate == predicate
    end
  end
end
