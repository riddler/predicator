require_relative "test_helper"

class ParserTest < Minitest::Test
  attr_accessor :parser

  def setup
    @parser = Predicator::Parser.new
  end

  def test_and_predicate_parsing
    assert parser.parse("true and true")
  end

  def test_or_predicate_parsing
    assert parser.parse("true or false")
  end

  def test_not_predicate_parsing
    assert parser.parse("!true")
  end

  def test_nested_predicate_parsing
    assert parser.parse("(true)")
    assert parser.parse("((true))")
  end

  def test_true_predicate_parsing
    assert parser.parse("true")
  end

  def test_false_predicate_parsing
    assert parser.parse("false")
  end

  def test_float_equals_parsing
    assert parser.parse("1.0=1.0")
  end

  def test_string_equals_parsing
    assert parser.parse('"foo"="foo"')
  end

  def test_date_equals_parsing
    assert parser.parse("2016-01-01 = 2016-01-01")
  end

  def test_integer_equals_parsing
    assert parser.parse("1=1")
    assert parser.parse("0 = -1")
    assert parser.parse("-1=-2")
    assert parser.parse(" -1 =  -2 ")
  end

  def test_integer_and_variable_equals_parsing
    assert parser.parse("a.b=1")
    assert parser.parse("0 = a.b_A")
    assert parser.parse("-1=-2")

    assert_raises Predicator::ParseError do
      parser.parse("a=1")
    end
  end

  def test_integer_not_equal_parsing
    assert parser.parse("1!=2")
  end

  def test_integer_greater_than_parsing
    assert parser.parse("1>2")
  end

  def test_integer_greater_than_or_equal_parsing
    assert parser.parse("1>=2")
  end

  def test_integer_less_than_parsing
    assert parser.parse("1<2")
  end

  def test_integer_less_than_or_equal_parsing
    assert parser.parse("1<=2")
  end

  def test_integer_between_parsing
    assert parser.parse("2 between 1 and 3")
  end
end
