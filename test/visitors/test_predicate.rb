require "helper"

module Predicator
  module Visitors
    class TestPredicate < Minitest::Test
      def setup
        @parser = Parser.new
      end

      def test_true
        assert_predicate Predicates::True, "true"
      end

      def test_false
        assert_predicate Predicates::False, "false"
      end

      def test_not
        assert_predicate Predicates::Not, "!true"

        ast = @parser.parse "!true"
        pred = ast.to_predicate
        assert_kind_of Predicates::True, pred.predicate
      end

      def assert_predicate klass, source
        ast = @parser.parse source
        pred = ast.to_predicate
        assert_kind_of klass, pred
      end
    end
  end
end
