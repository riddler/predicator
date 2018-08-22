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

      def test_variable_equals_integer
        assert_round_trip "foo = 1"
      end

      def test_variable_equals_string
        assert_round_trip "foo = 'foo'"
      end

      def test_variable_greater_than_integer
        assert_round_trip "foo > 1"
      end

      def test_variable_greater_than_string
        assert_round_trip "foo > 'foo'"
      end

      def test_variable_less_than_integer
        assert_round_trip "foo < 1"
      end

      def test_variable_less_than_string
        assert_round_trip "foo < 'foo'"
      end

      def test_integer_between_integers
        assert_round_trip "foo between 0 and 5"
      end

      def test_variable_in_integer_array
        assert_round_trip "foo in [1, 2]"
      end

      def test_variable_in_string_array
        assert_round_trip "foo in ['foo', 'bar']"
      end

      def test_variable_starts_with_string
        assert_round_trip "foo starts with 'bar'"
      end

      def test_variable_ends_with_string
        assert_round_trip "foo ends with 'bar'"
      end

      def test_variable_not_in_integer_array
        assert_round_trip "foo not in [1, 2]"
      end

      def test_variable_not_in_string_array
        assert_round_trip "foo not in ['foo', 'bar']"
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
