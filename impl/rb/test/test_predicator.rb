require "helper"

module Predicator

  class TestPredicator < Minitest::Test
    def test_parse
      ast = Predicator.parse "true"
      assert_equal :TRUE, ast.type
    end

    def test_compile
      instructions = Predicator.compile "true"
      assert_equal [["lit", true]], instructions
    end

    def test_evaluate
      result = Predicator.evaluate "true"
      assert result
    end

    def test_evaluate_instructions
      instructions = [["lit", true]]
      result = Predicator.evaluate_instructions instructions
      assert result
    end
  end
end
