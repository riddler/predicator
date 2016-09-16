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

      def test_unknown_named
        ast = @parser.parse "@not_found"

        assert_raises PredicateNotFoundError do
          ast.to_instructions
        end
      end

      def test_named
        Predicator.create name: "true_predicate", source: "true"

        assert_instructions "@true_predicate", [
          {op: "lit", lit: true},
        ]
      end

      def test_named_or_true
        Predicator.create name: "good_credit", source: "score > 700"

        assert_instructions "@good_credit or true", [
          {op: "read_var", var: "score"},
          {op: "lit", lit: 700},
          {op: "compare", comparison: "GT"},

          {op: "jump_if_true", label: "will_be_substituted"},
          {op: "lit", lit: true},
          {op: "label", label: "will_be_substituted"},
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
          if expected.key?(:label) && !generated.nil?
            expected[:label] = generated[:label]
          end
        end

        assert_equal expected_instructions, instructions
      end
    end
  end
end
