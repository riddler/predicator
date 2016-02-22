require_relative "../test_helper"

class NotEqualTest < Minitest::Test
  def test_integer_not_equal
    pred = Predicator::Predicates::NotEqual.new 1, 2
    assert pred.satisfied?
  end

  def test_float_not_equal
    pred = Predicator::Predicates::NotEqual.new 1.0, 2.0
    assert pred.satisfied?
  end

  def test_string_not_equal
    pred = Predicator::Predicates::NotEqual.new "foo", "bar"
    assert pred.satisfied?
  end

  def test_string_equal
    pred = Predicator::Predicates::NotEqual.new "foo", "foo"
    refute pred.satisfied?
  end

  def test_date_not_equal
    date1 = Date.new 2016, 01, 02
    date2 = Date.new 2016, 01, 03
    pred = Predicator::Predicates::NotEqual.new date1, date2
    assert pred.satisfied?
  end

  def test_date_equal
    date1 = Date.new 2016, 01, 02
    pred = Predicator::Predicates::NotEqual.new date1, date1
    refute pred.satisfied?
  end

  def test_integer_equal
    pred = Predicator::Predicates::NotEqual.new 1, 1
    refute pred.satisfied?
  end

  def test_integer_not_equal_variable
    context = Predicator::Context.new
    context[:a] = {b:1}
    variable = Predicator::Variable.new "a", "b"

    pred = Predicator::Predicates::NotEqual.new 2, variable

    assert pred.satisfied?(context)
  end
end
