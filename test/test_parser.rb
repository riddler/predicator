require "helper"

module Predicator
  class TestParser < Minitest::Test
    def setup
      @parser = Parser.new
    end

    def test_true
      assert_type :TRUE, "true"
    end

    def test_false
      assert_type :FALSE, "false"
    end

    def test_boolean_variable
      assert_type :BOOL, "foo"
    end

    def test_between
      ast = @parser.parse "1 between 0 and 5"

      assert_equal :BETWEEN, ast.type
      assert_equal :INTEGER, ast.left.type
      assert_equal :INTEGER, ast.middle.type
      assert_equal :INTEGER, ast.right.type
    end

    def test_not
      assert_type :NOT, "!true"
    end

    def test_group
      assert_type :GROUP, "(true)"
    end

    def test_integer_equals_integer
      ast = @parser.parse "1 = 1"

      assert_equal :EQ, ast.type
      assert_equal :INTEGER, ast.left.type
      assert_equal :INTEGER, ast.right.type
    end

    def test_integer_greater_than_integer
      ast = @parser.parse "1 > 1"

      assert_equal :GT, ast.type
      assert_equal :INTEGER, ast.left.type
      assert_equal :INTEGER, ast.right.type
    end

    def test_integer_less_than_integer
      ast = @parser.parse "1 < 1"

      assert_equal :LT, ast.type
      assert_equal :INTEGER, ast.left.type
      assert_equal :INTEGER, ast.right.type
    end

    def test_string_equals_string
      ast = @parser.parse "'foo' = 'foo'"

      assert_equal :EQ, ast.type
      assert_equal :STRING, ast.left.type
      assert_equal :STRING, ast.right.type
    end

    def test_variable_equals_string
      ast = @parser.parse "foo = 'foo'"

      assert_equal :EQ, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal "foo", ast.left.left
      assert_equal :STRING, ast.right.type
    end

    def test_variable_with_dot_equals_string
      ast = @parser.parse "foo.bar = 'foo'"

      assert_equal :EQ, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal "foo.bar", ast.left.left
      assert_equal :STRING, ast.right.type
    end

    def test_integer_in_array
      ast = @parser.parse "1 in [1,2]"

      assert_equal :IN, ast.type
      assert_equal :ARRAY, ast.right.type
    end

    def test_integer_not_in_array
      ast = @parser.parse "3 not in [1,2]"

      assert_equal :NOTIN, ast.type
      assert_equal :ARRAY, ast.right.type
    end

    def assert_type type, source
      assert_equal type, @parser.parse(source).type
    end
  end
end
