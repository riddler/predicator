module Predicator
  module Predicates
    class LessThanOrEqual < Predicator::Predicates::Relation
      def compare_values lhs, rhs
        lhs <= rhs
      end
    end
  end
end
