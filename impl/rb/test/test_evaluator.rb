require "helper"

module Predicator
  class TestEvaluator < Minitest::Test
    def test_true
      assert_eval true, [{op: "lit", lit: true}]
    end

    def test_false
      assert_eval false, [{op: "lit", lit: false}]
    end

    def test_integer_equal_integer
      assert_eval true, [
        {op: "lit", lit: 1},
        {op: "lit", lit: 1},
        {op: "compare", comparison: "EQ"},
      ]
    end

    #--- AND
    def test_true_and_true
      assert_eval true, [
        {op: "lit", lit: true},
        {op: "jump_if_false", label: "end_and"},
        {op: "lit", lit: true},
        {op: "label", label: "end_and"},
      ]
    end

    def test_false_and_false
      assert_eval false, [
        {op: "lit", lit: false},
        {op: "jump_if_false", label: "end_and"},
        {op: "lit", lit: false},
        {op: "label", label: "end_and"},
      ]
    end

    def test_false_and_true
      assert_eval false, [
        {op: "lit", lit: false},
        {op: "jump_if_false", label: "end_and"},
        {op: "lit", lit: true},
        {op: "label", label: "end_and"},
      ]
    end

    def test_true_and_false
      assert_eval false, [
        {op: "lit", lit: true},
        {op: "jump_if_false", label: "end_and"},
        {op: "lit", lit: false},
        {op: "label", label: "end_and"},
      ]
    end

    #--- OR
    def test_true_or_true
      assert_eval true, [
        {op: "lit", lit: true},
        {op: "jump_if_true", label: "end_or"},
        {op: "lit", lit: true},
        {op: "label", label: "end_or"},
      ]
    end

    def test_false_or_false
      assert_eval false, [
        {op: "lit", lit: false},
        {op: "jump_if_true", label: "end_or"},
        {op: "lit", lit: false},
        {op: "label", label: "end_or"},
      ]
    end

    def test_false_or_true
      assert_eval true, [
        {op: "lit", lit: false},
        {op: "jump_if_true", label: "end_or"},
        {op: "lit", lit: true},
        {op: "label", label: "end_or"},
      ]
    end

    def test_true_or_false
      assert_eval true, [
        {op: "lit", lit: true},
        {op: "jump_if_true", label: "end_or"},
        {op: "lit", lit: false},
        {op: "label", label: "end_or"},
      ]
    end

    def assert_eval result, instructions
      e = Evaluator.new instructions
      assert_equal result, e.result
      assert_empty e.stack
    end
  end
end
