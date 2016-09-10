require "helper"

module Predicator
  class TestParser < Minitest::Test
    def setup
      @parser = Parser.new
    end

    def test_true
      assert_type :TRUE, "true"
      assert_round_trip "true"
    end

    def test_false
      assert_type :FALSE, "false"
      assert_round_trip "false"
    end

    def test_not
      assert_type :NOT, "!true"
      assert_round_trip "!true"
      assert_to_s "!true", "! true"
    end

    def test_group
      assert_round_trip "(true)"
      assert_to_s "(true)", "( true )"
    end

    def test_integer_equals_integer
      ast = @parser.parse "1 = 1"

      assert_equal :EQUAL, ast.type
      assert_equal :INTEGER, ast.left.type
      assert_equal :INTEGER, ast.right.type

      assert_round_trip "1 = 1"
    end

    def test_string_equals_string
      ast = @parser.parse "'foo' = 'foo'"

      assert_equal :EQUAL, ast.type
      assert_equal :STRING, ast.left.type
      assert_equal :STRING, ast.right.type

      assert_round_trip "'foo' = 'foo'"
    end

    def test_variable_equals_string
      ast = @parser.parse "foo = 'foo'"

      assert_equal :EQUAL, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :STRING, ast.right.type

      assert_round_trip "foo = 'foo'"
    end


    def assert_type type, source
      assert_equal type, @parser.parse(source).type
    end

    def assert_to_s str, source
      assert_equal str, @parser.parse(source).to_s
    end

    def assert_round_trip str
      assert_to_s str, str
    end
  end
end
