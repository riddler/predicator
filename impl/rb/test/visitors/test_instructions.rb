require "helper"

module Predicator
  module Visitors
    class TestInstructions < Minitest::Test
      make_my_diffs_pretty!

      def setup
        @parser = Parser.new
      end

      def test_true
        assert_instructions "true", [{op: "lit", lit: true}]
      end

      def test_false
        assert_instructions "false", [{op: "lit", lit: false}]
      end

      def test_group
        assert_instructions "(true)", [{op: "lit", lit: true}]
      end

      def test_not
        assert_instructions "!true", [
          {op: "lit", lit: true},
          {op: "not"},
        ]
      end

      def test_integer_equal_integer
        assert_instructions "1=1", [
          {op: "lit", lit: 1},
          {op: "lit", lit: 1},
          {op: "compare", comparison: "EQ"},
        ]
      end

      def test_variable_equal_integer
        assert_instructions "age=21", [
          {op: "read_var", var: "age"},
          {op: "lit", lit: 21},
          {op: "compare", comparison: "EQ"},
        ]
      end

      def test_integer_greater_than_integer
        assert_instructions "2>1", [
          {op: "lit", lit: 2},
          {op: "lit", lit: 1},
          {op: "compare", comparison: "GT"},
        ]
      end

      def test_true_and_true
        assert_instructions "true and true", [
          {op: "lit", lit: true},
          {op: "jump_if_false", offset: 2},
          {op: "lit", lit: true}
        ]
      end

      def test_true_or_false
        assert_instructions "true or false", [
          {op: "lit", lit: true},
          {op: "jump_if_true", offset: 2},
          {op: "lit", lit: false}
        ]
      end

      def test_false_or_integer_equal_integer
        assert_instructions "false or 1=1", [
          {op: "lit", lit: false},
          {op: "jump_if_true", offset: 4},
          {op: "lit", lit: 1},
          {op: "lit", lit: 1},
          {op: "compare", comparison: "EQ"}
        ]
      end

      # assert equal instructions, EXCEPT for labels which are
      # substituted for the generated labels
      def assert_instructions source, expected_instructions
        ast = @parser.parse source
        instructions = ast.to_instructions

        expected_instructions.each_with_index do |expected, idx|
          generated = instructions[idx]
          if expected.key?(:label) && !generated.nil?
            expected[:label] = generated[:label]
          end
        end

        assert_equal expected_instructions, instructions
      end
    end
  end
end
