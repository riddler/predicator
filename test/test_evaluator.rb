require "helper"

module Predicator
  class TestEvaluator < Minitest::Test
    def test_true
      assert_eval true, [{op: "lit", lit: true}]
    end

    def test_false
      assert_eval false, [{op: "lit", lit: false}]
    end

    def test_not
      assert_eval false, [
        {op: "lit", lit: true},
        {op: "not"},
      ]
    end

    def test_read_var
      instructions = [{op: "read_var", var: "age"}]
      context = {age: 21}

      e = Evaluator.new instructions, context
      e.process instructions.first
      assert_equal 21, e.stack[-1]
    end

    def test_integer_equal_integer
      assert_eval true, [
        {op: "lit", lit: 1},
        {op: "lit", lit: 1},
        {op: "compare", comparison: "EQ"},
      ]
    end

    # age > 21
    def test_undefined_variable_greater_than_integer
      assert_eval false, [
        {op: "read_var", var: "age"},
        {op: "lit", lit: 21},
        {op: "compare", comparison: "GT"},
      ]
    end

    # 21 > age
    def test_integer_greater_than_undefined_variable
      assert_eval false, [
        {op: "lit", lit: 21},
        {op: "read_var", var: "age"},
        {op: "compare", comparison: "GT"},
      ]
    end

    # age > 21
    def test_variable_greater_than_integer
      assert_eval false, [
        {op: "read_var", var: "age"},
        {op: "lit", lit: 21},
        {op: "compare", comparison: "GT"},
      ], age: 10

      assert_eval true, [
        {op: "read_var", var: "age"},
        {op: "lit", lit: 21},
        {op: "compare", comparison: "GT"},
      ], age: 22
    end

    #--- AND
    def test_true_and_true
      assert_eval true, [
        {op: "lit", lit: true},
        {op: "jump_if_false", to: 3},
        {op: "lit", lit: true},
        {op: "label", label: "end_and"},
      ]
    end

    def test_false_and_false
      assert_eval false, [
        {op: "lit", lit: false},
        {op: "jump_if_false", to: 3},
        {op: "lit", lit: false},
        {op: "label", label: "end_and"},
      ]
    end

    def test_false_and_true
      assert_eval false, [
        {op: "lit", lit: false},
        {op: "jump_if_false", to: 3},
        {op: "lit", lit: true},
        {op: "label", label: "end_and"},
      ]
    end

    def test_true_and_false
      assert_eval false, [
        {op: "lit", lit: true},
        {op: "jump_if_false", to: 3},
        {op: "lit", lit: false},
        {op: "label", label: "end_and"},
      ]
    end

    #--- OR
    def test_true_or_true
      assert_eval true, [
        {op: "lit", lit: true},
        {op: "jump_if_true", to: 3},
        {op: "lit", lit: true},
        {op: "label", label: "end_or"},
      ]
    end

    def test_false_or_false
      assert_eval false, [
        {op: "lit", lit: false},
        {op: "jump_if_true", to: 3},
        {op: "lit", lit: false},
        {op: "label", label: "end_or"},
      ]
    end

    def test_false_or_true
      assert_eval true, [
        {op: "lit", lit: false},
        {op: "jump_if_true", to: 3},
        {op: "lit", lit: true},
        {op: "label", label: "end_or"},
      ]
    end

    def test_true_or_false
      assert_eval true, [
        {op: "lit", lit: true},
        {op: "jump_if_true", to: 3},
        {op: "lit", lit: false},
        {op: "label", label: "end_or"},
      ]
    end

    def assert_eval result, instructions, context={}
      e = Evaluator.new instructions, context
      assert_equal result, e.result
      assert_empty e.stack
    end
  end
end
