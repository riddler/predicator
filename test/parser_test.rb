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

  def test_integer_parsing
    p = parser.integer
    assert p.parse("1")
    assert p.parse("0")
    assert p.parse("-1")
  end

  def test_variable_parsing
    p = parser.variable
    assert p.parse("user.age"), "Should parse 'user.age'"
    assert p.parse("user.valid?"), "Should parse 'user.valid?'"
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

  def test_equals_parsing
    p = parser.equals_predicate
    assert p.parse("1 = 0")
    assert p.parse("foo.bar = 2")
    assert p.parse("2 = foo.bar")
    assert p.parse("baz.wat = foo.bar")
  end
end
