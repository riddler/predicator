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

      def test_group
        assert_instructions "(true)", [["lit", true]]
      end

      def test_not
        assert_instructions "!true", [
          ["lit", true],
          ["not"]
        ]
      end

      def test_integer_equal_integer
        assert_instructions "1=1", [
          ["lit", 1],
          ["lit", 1],
          ["compare", "EQ"],
        ]
      end

      def test_variable_equal_integer
        assert_instructions "age=21", [
          ["load", "age"],
          ["lit", 21],
          ["compare", "EQ"],
        ]
      end

      def test_integer_greater_than_integer
        assert_instructions "2>1", [
          ["lit", 2],
          ["lit", 1],
          ["compare", "GT"],
        ]
      end

      def test_integer_greater_than_integer
        assert_instructions "2<1", [
          ["lit", 2],
          ["lit", 1],
          ["compare", "LT"],
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

      def test_false_or_integer_equal_integer
        assert_instructions "false or 1=1", [
          ["lit", false],
          ["jtrue", 4],
          ["lit", 1],
          ["lit", 1],
          ["compare", "EQ"],
        ]
      end

      # "(true or true or true) or true"
      def test_group_true_or_true_or_true_or_true
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
