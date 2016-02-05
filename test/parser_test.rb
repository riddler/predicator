require_relative "test_helper"

class ParserTest < Minitest::Test
  attr_accessor :parser

  def setup
    @parser = Predicator::Parser.new
  end

  def test_boolean_parsing
    p = parser.boolean
    assert p.parse("true")
    assert p.parse("false")
  end

  def test_or_parsing
    p = parser.or_predicate
    assert p.parse("or(true)")
    assert p.parse("or(true, false)")
  end

  def test_and_parsing
    p = parser.and_predicate
    assert p.parse("and(true)")
    assert p.parse("and(true, or(true,false))")
  end
end
