require_relative "../test_helper"

class EqualsTest < Minitest::Test
  def test_integer_equals
    pred = Predicator::Predicates::Equals.new 1, 1
    assert pred.satisfied?
  end

  def test_integer_not_equals
    pred = Predicator::Predicates::Equals.new 1, 2
    refute pred.satisfied?
  end

  def test_integer_equals_variable
    context = Predicator::Context.new
    context[:a] = {b:1}
    variable = Predicator::Variable.new "a", "b"

    pred = Predicator::Predicates::Equals.new 1, variable

    assert pred.satisfied?(context)
  end
end
