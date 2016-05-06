module Predicator
  module Predicates
    class GreaterThan < Predicator::Predicates::Relation
      def compare_values lhs, rhs
        lhs > rhs
      end
    end
  end
end
