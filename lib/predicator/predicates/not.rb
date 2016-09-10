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
    end

  end
end
