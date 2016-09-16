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

    def test_not
      assert_type :NOT, "!true"
    end

    def test_group
      assert_type :GROUP, "(true)"
    end

    def test_named
      assert_type :NAMED, "@foo"
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
      assert_equal :STRING, ast.right.type
    end

    def assert_type type, source
      assert_equal type, @parser.parse(source).type
    end
  end
end
