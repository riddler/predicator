require_relative "../test_helper"

class EqualsTest < Minitest::Test
  def test_integer_equals
    pred = Predicator::Predicates::Equals.new 1, 1
    assert pred.satisfied?
  end

  def test_float_equals
    pred = Predicator::Predicates::Equals.new 1.0, 1.0
    assert pred.satisfied?
  end

  def test_string_equals
    pred = Predicator::Predicates::Equals.new "foo", "foo"
    assert pred.satisfied?
  end

  def test_string_not_equals
    pred = Predicator::Predicates::Equals.new "foo", "bar"
    refute pred.satisfied?
  end

  def test_date_equals
    date1 = Date.new 2016, 01, 02
    pred = Predicator::Predicates::Equals.new date1, date1
    assert pred.satisfied?
  end

  def test_date_not_equals
    date1 = Date.new 2016, 01, 02
    date2 = Date.new 2016, 01, 03
    pred = Predicator::Predicates::Equals.new date1, date2
    refute pred.satisfied?
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
