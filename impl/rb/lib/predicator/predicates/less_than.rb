module Predicator
  module Predicates
    class LessThan < Predicator::Predicates::Relation
      def compare_values lhs, rhs
        lhs < rhs
      end
    end
  end
end
