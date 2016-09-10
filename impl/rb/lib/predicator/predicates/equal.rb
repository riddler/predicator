module Predicator
  module Predicates
    class NilValueError < StandardError; end

    class Equal < Comparison
      def compare_values lhs, rhs
        lhs == rhs
      end
    end

  end
end
