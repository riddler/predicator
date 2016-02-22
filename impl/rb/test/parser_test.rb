require_relative "test_helper"

class ParserTest < Minitest::Test
  attr_accessor :parser

  def setup
    @parser = Predicator::Parser.new
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
end
