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

    def test_not
      assert_type :NOT, "!true"
    end

    def test_group
      assert_type :GROUP, "(true)"
    end


    # VARIABLE COMPARE INTEGER
    def test_variable_equals_integer
      ast = @parser.parse "foo = 1"

      assert_equal :INTEQ, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :INTEGER, ast.right.type
    end

    def test_variable_greater_than_integer
      ast = @parser.parse "foo > 1"

      assert_equal :INTGT, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :INTEGER, ast.right.type
    end

    def test_variable_less_than_integer
      ast = @parser.parse "foo < 1"

      assert_equal :INTLT, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :INTEGER, ast.right.type
    end

    def test_variable_between_integers
      ast = @parser.parse "foo between 0 and 5"

      assert_equal :INTBETWEEN, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :INTEGER, ast.middle.type
      assert_equal :INTEGER, ast.right.type
    end

    def test_variable_in_integer_array
      ast = @parser.parse "foo in [1,2]"

      assert_equal :INTIN, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :INTARRAY, ast.right.type
    end

    def test_variable_not_in_array
      ast = @parser.parse "foo not in [1,2]"

      assert_equal :INTNOTIN, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :INTARRAY, ast.right.type
    end


    # VARIABLE COMPARE STRING
    def test_variable_equals_string
      ast = @parser.parse "foo = 'foo'"

      assert_equal :STREQ, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :STRING, ast.right.type
    end

    # def test_variable_equals_string
    #   ast = @parser.parse "foo = 'foo'"

    #   assert_equal :EQ, ast.type
    #   assert_equal :VARIABLE, ast.left.type
    #   assert_equal "foo", ast.left.left
    #   assert_equal :STRING, ast.right.type
    # end

    # def test_variable_with_dot_equals_string
    #   ast = @parser.parse "foo.bar = 'foo'"

    #   assert_equal :EQ, ast.type
    #   assert_equal :VARIABLE, ast.left.type
    #   assert_equal "foo.bar", ast.left.left
    #   assert_equal :STRING, ast.right.type
    # end

    def assert_type type, source
      assert_equal type, @parser.parse(source).type
    end
  end
end
