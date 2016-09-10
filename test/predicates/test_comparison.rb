require "helper"

module Predicator
  module Predicates
    class TestComparison < Minitest::Test
      def test_nil_values_for_comparison
        skip
        pred = Comparison.new 1, nil

        assert_raises NilValueError do
          pred.values_for_comparison
        end
      end
    end
  end
end
