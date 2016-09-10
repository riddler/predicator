require "helper"

module Predicator
  class TestEvaluator < Minitest::Test
    def test_true
      instructions = [{op: "lit", lit: true}]
      e = Evaluator.new instructions
      assert_equal true, e.result
    end

    def test_false
      instructions = [{op: "lit", lit: false}]
      e = Evaluator.new instructions
      assert_equal false, e.result
    end

    def test_integer_equal_integer
      instructions = [
        {op: "lit", lit: 1},
        {op: "lit", lit: 1},
        {op: "compare", comparison: "EQ"},
      ]
      e = Evaluator.new instructions
      assert_equal true, e.result
    end

    #--- AND
    def test_true_and_true
      instructions = [
        {op: "lit", lit: true},
        {op: "jump_if_false", label: "end_and"},
        {op: "lit", lit: true},
        {op: "label", label: "end_and"},
      ]
      e = Evaluator.new instructions
      assert_equal true, e.result
      assert_empty e.stack
    end

    def test_false_and_false
      instructions = [
        {op: "lit", lit: false},
        {op: "jump_if_false", label: "end_and"},
        {op: "lit", lit: false},
        {op: "label", label: "end_and"},
      ]
      e = Evaluator.new instructions
      assert_equal false, e.result
      assert_empty e.stack
    end

    def test_false_and_true
      instructions = [
        {op: "lit", lit: false},
        {op: "jump_if_false", label: "end_and"},
        {op: "lit", lit: true},
        {op: "label", label: "end_and"},
      ]
      e = Evaluator.new instructions
      assert_equal false, e.result
      assert_empty e.stack
    end

    def test_true_and_false
      instructions = [
        {op: "lit", lit: true},
        {op: "jump_if_false", label: "end_and"},
        {op: "lit", lit: false},
        {op: "label", label: "end_and"},
      ]
      e = Evaluator.new instructions
      assert_equal false, e.result
      assert_empty e.stack
    end

    #--- OR
    def test_true_or_true
      instructions = [
        {op: "lit", lit: true},
        {op: "jump_if_true", label: "end_or"},
        {op: "lit", lit: true},
        {op: "label", label: "end_or"},
      ]
      e = Evaluator.new instructions
      assert_equal true, e.result
      assert_empty e.stack
    end

    def test_false_or_false
      instructions = [
        {op: "lit", lit: false},
        {op: "jump_if_true", label: "end_or"},
        {op: "lit", lit: false},
        {op: "label", label: "end_or"},
      ]
      e = Evaluator.new instructions
      assert_equal false, e.result
      assert_empty e.stack
    end

    def test_false_or_true
      instructions = [
        {op: "lit", lit: false},
        {op: "jump_if_true", label: "end_or"},
        {op: "lit", lit: true},
        {op: "label", label: "end_or"},
      ]
      e = Evaluator.new instructions
      assert_equal true, e.result
      assert_empty e.stack
    end

    def test_true_or_false
      instructions = [
        {op: "lit", lit: true},
        {op: "jump_if_true", label: "end_or"},
        {op: "lit", lit: false},
        {op: "label", label: "end_or"},
      ]
      e = Evaluator.new instructions
      assert_equal true, e.result
      assert_empty e.stack
    end

  end
end
