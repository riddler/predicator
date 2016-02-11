module Predicator
  module Predicates
    class Not
      attr_reader :predicate

      def initialize predicate
        @predicate = predicate
      end

      def satisfied? context=Context.new
        !predicate.satisfied? context
      end

      def == other
        other.kind_of?(self.class) && other.predicate == predicate
      end
    end
  end
end
