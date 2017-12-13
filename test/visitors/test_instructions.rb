require "helper"

module Predicator
  module Visitors
    class TestInstructions < Minitest::Test
      make_my_diffs_pretty!

      def setup
        @parser = Parser.new
      end

      def test_true
        assert_instructions "true", [["lit", true]]
      end

      def test_false
        assert_instructions "false", [["lit", false]]
      end

      def test_boolean
        assert_instructions "bool_var", [
          ["load", "bool_var"],
          ["to_bool"],
        ]
      end

      def test_group
        assert_instructions "(true)", [["lit", true]]
      end

      def test_not
        assert_instructions "!true", [
          ["lit", true],
          ["not"]
        ]
      end

      def test_variable_equal_integer
        assert_instructions "foo=1", [
          ["load", "foo"],
          ["to_int"],
          ["lit", 1],
          ["compare", "EQ"],
        ]
      end

      def test_variable_equal_string
        assert_instructions "foo='bar'", [
          ["load", "foo"],
          ["to_str"],
          ["lit", "bar"],
          ["compare", "EQ"],
        ]
      end

      def test_variable_greater_than_integer
        assert_instructions "foo>1", [
          ["load", "foo"],
          ["to_int"],
          ["lit", 1],
          ["compare", "GT"],
        ]
      end

      def test_variable_greater_than_string
        assert_instructions "foo>'bar'", [
          ["load", "foo"],
          ["to_str"],
          ["lit", "bar"],
          ["compare", "GT"],
        ]
      end

      def test_variable_less_than_integer
        assert_instructions "foo<1", [
          ["load", "foo"],
          ["to_int"],
          ["lit", 1],
          ["compare", "LT"],
        ]
      end

      def test_variable_less_than_string
        assert_instructions "foo<'bar'", [
          ["load", "foo"],
          ["to_str"],
          ["lit", "bar"],
          ["compare", "LT"],
        ]
      end

      def test_variable_in_integer_array
        assert_instructions "foo in [1, 2]", [
          ["load", "foo"],
          ["to_int"],
          ["array", [1, 2]],
          ["compare", "IN"],
        ]
      end

      def test_variable_in_array
        assert_instructions "foo in ['foo', 'bar']", [
          ["load", "foo"],
          ["to_str"],
          ["array", ["foo", "bar"]],
          ["compare", "IN"],
        ]
      end

      def test_variable_not_in_integer_array
        assert_instructions "foo not in [1, 2]", [
          ["load", "foo"],
          ["to_int"],
          ["array", [1, 2]],
          ["compare", "NOTIN"],
        ]
      end

      def test_variable_not_in_array
        assert_instructions "foo not in ['foo', 'bar']", [
          ["load", "foo"],
          ["to_str"],
          ["array", ["foo", "bar"]],
          ["compare", "NOTIN"],
        ]
      end

      def test_variable_between_integers
        assert_instructions "foo between 1 and 2", [
          ["load", "foo"],
          ["to_int"],
          ["lit", 1],
          ["lit", 2],
          ["compare", "BETWEEN"],
        ]
      end

      def test_true_and_true
        assert_instructions "true and true", [
          ["lit", true],
          ["jfalse", 2],
          ["lit", true],
        ]
      end

      def test_true_or_false
        assert_instructions "true or false", [
          ["lit", true],
          ["jtrue", 2],
          ["lit", false],
        ]
      end

      def test_false_or_variable_equal_integer
        assert_instructions "false or foo=1", [
          ["lit", false],
          ["jtrue", 5],
          ["load", "foo"],
          ["to_int"],
          ["lit", 1],
          ["compare", "EQ"],
        ]
      end

      def test_false_or_variable_equal_str
        assert_instructions "false or foo='bar'", [
          ["lit", false],
          ["jtrue", 5],
          ["load", "foo"],
          ["to_str"],
          ["lit", "bar"],
          ["compare", "EQ"],
        ]
      end

      # "(true or true or true) or true"
      def test_correct_jump_offsets
        assert_instructions "(true or true or true) or true", [
          ["lit", true], ["jtrue", 4], ["lit", true], ["jtrue", 2], ["lit", true],
          ["jtrue", 2], ["lit", true],
        ]
      end

      def assert_instructions source, expected_instructions
        ast = @parser.parse source
        instructions = ast.to_instructions
        assert_equal expected_instructions, instructions
      end
    end
  end
end
