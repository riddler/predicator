require "helper"

module Predicator
  class TestEvaluator < Minitest::Test
    def test_true
      assert_eval true, [["lit", true]]
    end

    def test_false
      assert_eval false, [["lit", false]]
    end

    def test_bool_undefined
      assert_eval false, [
        ["load", "bool_var"],
        ["to_bool"],
      ]
    end

    def test_bool_false
      assert_eval false, [
        ["load", "bool_var"],
        ["to_bool"],
      ], bool_var: false
    end

    def test_bool
      assert_eval true, [
        ["load", "bool_var"],
        ["to_bool"],
      ], bool_var: true
    end

    def test_not
      assert_eval false, [
        ["lit", true],
        ["not"]
      ]
    end

    def test_load
      instructions = [["load", "age"]]
      context = {age: 21}

      e = Evaluator.new instructions, context
      e.process instructions.first
      assert_equal 21, e.stack[-1]
    end

    def test_integer_equal_integer
      assert_eval true, [
        ["lit", 1],
        ["lit", 1],
        ["compare", "EQ"],
      ]
    end

    def test_integer_in_array
      assert_eval true, [
        ["lit", 1],
        ["array", [1, 2]],
        ["compare", "IN"],
      ]
    end

    def test_integer_not_in_array
      assert_eval true, [
        ["lit", 3],
        ["array", [1, 2]],
        ["compare", "NOTIN"],
      ]
    end

    def test_string_in_array
      assert_eval true, [
        ["lit", "UT"],
        ["array", ["UT", "NM"]],
        ["compare", "IN"],
      ]
    end

    def test_string_not_in_array
      assert_eval true, [
        ["lit", "NY"],
        ["array", ["UT", "NM"]],
        ["compare", "NOTIN"],
      ]
    end

    # age > 21
    def test_undefined_variable_greater_than_integer
      assert_eval false, [
        ["load", "age"],
        ["lit", 21],
        ["compare", "GT"],
      ]
    end

    # 21 > age
    def test_integer_greater_than_undefined_variable
      assert_eval false, [
        ["lit", 21],
        ["load", "age"],
        ["compare", "GT"],
      ]
    end

    # age = 21
    def test_variable_equal_to_integer
      assert_eval true, [
        ["load", "age"],
        ["to_int"],
        ["lit", 21],
        ["compare", "EQ"],
      ], age: "21"
    end

    # age > 21
    def test_variable_greater_than_integer
      assert_eval false, [
        ["load", "age"],
        ["lit", 21],
        ["compare", "GT"],
      ], age: 10

      assert_eval true, [
        ["load", "age"],
        ["lit", 21],
        ["compare", "GT"],
      ], age: 22
    end

    def test_variable_less_than_integer
      assert_eval true, [
        ["load", "age"],
        ["lit", 21],
        ["compare", "LT"],
      ], age: 10

      assert_eval false, [
        ["load", "age"],
        ["lit", 21],
        ["compare", "LT"],
      ], age: 22
    end

    # 2 between 1 and 5
    def test_integer_between_integers
      assert_eval true, [
        ["lit", 2],
        ["lit", 1],
        ["lit", 5],
        ["compare", "BETWEEN"],
      ]

      assert_eval true, [
        ["lit", 1],
        ["lit", 1],
        ["lit", 5],
        ["compare", "BETWEEN"],
      ]

      assert_eval true, [
        ["lit", 5],
        ["lit", 1],
        ["lit", 5],
        ["compare", "BETWEEN"],
      ]
    end

    #--- AND
    def test_true_and_true
      assert_eval true, [
        ["lit", true],
        ["jfalse", 2],
        ["lit", true],
      ]
    end

    def test_false_and_false
      assert_eval false, [
        ["lit", false],
        ["jfalse", 2],
        ["lit", false],
      ]
    end

    def test_false_and_true
      assert_eval false, [
        ["lit", false],
        ["jfalse", 2],
        ["lit", true],
      ]
    end

    def test_true_and_false
      assert_eval false, [
        ["lit", true],
        ["jfalse", 2],
        ["lit", false],
      ]
    end

    #--- OR
    def test_true_or_true
      assert_eval true, [
        ["lit", true],
        ["jtrue", 2],
        ["lit", true],
      ]
    end

    def test_false_or_false
      assert_eval false, [
        ["lit", false],
        ["jtrue", 2],
        ["lit", false],
      ]
    end

    def test_false_or_true
      assert_eval true, [
        ["lit", false],
        ["jtrue", 2],
        ["lit", true],
      ]
    end

    def test_true_or_false
      assert_eval true, [
        ["lit", true],
        ["jtrue", 2],
        ["lit", false],
      ]
    end

    # "(true or (false and false)) and 1 > 2"
    def test_jump_offset
      assert_eval false, [
        ["lit", true], ["jtrue", 4], ["lit", false], ["jfalse", 2], ["lit", false],
        ["jfalse", 4], ["lit", 1], ["lit", 2], ["compare", "GT"],
      ]
    end

    # "(true or true or true) or true"
    def test_should_result_in_empty_stack
      assert_eval true, [
        ["lit", true], ["jtrue", 4], ["lit", true], ["jtrue", 2], ["lit", true],
        ["jtrue", 2], ["lit", true],
      ]
    end

    def test_invalid_compare_rescues_error
      assert_eval false, [
        ["lit", "foo"],
        ["lit", 5],
        ["compare", "GT"],
      ]
    end

    def test_invalid_between_rescues_error
      assert_eval false, [
        ["lit", "foo"],
        ["lit", 1],
        ["lit", 5],
        ["compare", "BETWEEN"],
      ]
    end

    def assert_eval result, instructions, context={}
      e = Evaluator.new instructions, context
      assert_equal result, e.result
      assert_empty e.stack
    end
  end
end
