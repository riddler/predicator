require "helper"

module Predicator
  module Visitors
    class TestString < Minitest::Test
      def setup
        @parser = Parser.new
      end

      def test_true
        ast = AST::True.new "true"
        assert_equal "true", ast.to_s
      end

      def test_false
        ast = AST::False.new "false"
        assert_equal "false", ast.to_s
      end

      def test_not
        ast = AST::Not.new(AST::True.new "true")
        assert_equal "!true", ast.to_s
      end

      def test_group
        ast = AST::Group.new(AST::True.new "true")
        assert_equal "(true)", ast.to_s
        assert_round_trip "(true)"
        assert_to_s "(true)", "( true )"
      end

      def test_integer_equals_integer
        assert_round_trip "1 = 1"
      end

      def test_integer_in_array
        assert_round_trip "1 in [1, 2]"
      end

      def test_integer_not_in_array
        assert_round_trip "3 not in [1, 2]"
      end

      def test_integer_greater_than_integer
        assert_round_trip "1 > 1"
      end

      def test_integer_less_than_integer
        assert_round_trip "1 < 1"
      end

      def test_integer_between_integers
        assert_round_trip "1 between 0 and 5"
      end

      def test_string_equals_string
        assert_round_trip "'foo' = 'foo'"
      end

      def test_variable_equals_string
        assert_round_trip "foo = 'foo'"
      end


      def assert_to_s str, source
        assert_equal str, @parser.parse(source).to_s
      end

      def assert_round_trip str
        assert_to_s str, str
      end
    end
  end
end
