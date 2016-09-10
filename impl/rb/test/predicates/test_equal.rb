require "helper"

module Predicator
  module Predicates
    class TestEqual < Minitest::Test
      def test_integer_equal_integer
        pred = Equal.new 1, 1
        assert pred.satisfied?
      end

      def test_integer_not_equal_integer
        pred = Equal.new 1, 2
        refute pred.satisfied?
      end

      def test_string_equal_integer
        skip
        pred = Equal.new "1", 1
        assert pred.satisfied?
      end

      def test_variable_equal_integer
        skip
        var = Variable.new "age"
        pred = Equal.new var, 21
        context = Context.new age: 21
        assert pred.satisfied?(context)
      end
    end
  end
end
