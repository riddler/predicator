module Predicator
  module Predicates
    class Or
      attr_reader :predicates

      def initialize predicates
        @predicates = predicates
      end

      def satisfied? context=Context.new
        predicates.any?{ |pred| pred.satisfied? context }
      end

      def == other
        other.kind_of?(self.class) &&
          other.predicates == predicates
      end
    end
  end
end
