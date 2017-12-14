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

    def test_variable_not_in_integer_array
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
      assert_equal "foo", ast.left.left
      assert_equal :STRING, ast.right.type
    end

    def test_variable_with_dot_equals_string
      ast = @parser.parse "foo.bar = 'foo'"

      assert_equal :STREQ, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal "foo.bar", ast.left.left
      assert_equal :STRING, ast.right.type
    end

    def test_variable_greater_than_string
      ast = @parser.parse "foo > 'bar'"

      assert_equal :STRGT, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :STRING, ast.right.type
    end

    def test_variable_less_than_string
      ast = @parser.parse "foo < 'bar'"

      assert_equal :STRLT, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :STRING, ast.right.type
    end

    def test_variable_in_string_array
      ast = @parser.parse "foo in ['foo','bar']"

      assert_equal :STRIN, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :STRARRAY, ast.right.type
    end

    def test_variable_not_in_string_array
      ast = @parser.parse "foo not in ['foo','bar']"

      assert_equal :STRNOTIN, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :STRARRAY, ast.right.type
    end

    def test_variable_equal_date
      ast = @parser.parse "foo = 2018-07-10"

      assert_equal :DATEQ, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :DATE, ast.right.type
    end

    def test_variable_greater_than_date
      ast = @parser.parse "foo > 2018-07-10"

      assert_equal :DATGT, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :DATE, ast.right.type
    end

    def test_variable_less_than_date
      ast = @parser.parse "foo < 2018-07-10"

      assert_equal :DATLT, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :DATE, ast.right.type
    end

    def test_variable_between_date_and_date
      ast = @parser.parse "foo between 2018-07-10 and 2018-07-20"

      assert_equal :DATBETWEEN, ast.type
      assert_equal :VARIABLE, ast.left.type
      assert_equal :DATE, ast.middle.type
      assert_equal :DATE, ast.right.type
    end

    def assert_type type, source
      assert_equal type, @parser.parse(source).type
    end
  end
end
