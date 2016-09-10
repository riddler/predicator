require "helper"

module Predicator
  module Visitors
    class TestInstructions < Minitest::Test
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

      def test_integer_equal_integer
        assert_instructions "1=1", [
          {op: "lit", lit: 1},
          {op: "lit", lit: 1},
          {op: "compare", comparison: "EQ"},
        ]
      end

      def test_true_and_true
        assert_instructions "true and true", [
          {op: "lit", lit: true},
          {op: "jump_if_false", label: "will_be_substituted"},
          {op: "lit", lit: true},
          {op: "label", label: "will_be_substituted"},
        ]
      end

      def test_true_or_false
        assert_instructions "true or false", [
          {op: "lit", lit: true},
          {op: "jump_if_true", label: "will_be_substituted"},
          {op: "lit", lit: false},
          {op: "label", label: "will_be_substituted"},
        ]
      end

      def test_false_or_integer_equal_integer
        assert_instructions "false or 1=1", [
          {op: "lit", lit: false},
          {op: "jump_if_true", label: "will_be_substituted"},
          {op: "lit", lit: 1},
          {op: "lit", lit: 1},
          {op: "compare", comparison: "EQ"},
          {op: "label", label: "will_be_substituted"},
        ]
      end

      # assert equal instructions, EXCEPT for labels which are
      # substituted for the generated labels
      def assert_instructions source, expected_instructions
        ast = @parser.parse source
        instructions = ast.to_instructions

        expected_instructions.each_with_index do |expected, idx|
          generated = instructions[idx]
          if expected.key? :label
            expected[:label] = generated[:label]
          end
          assert_equal expected, generated
        end
      end
    end
  end
end
