require_relative "../test_helper"

class GreaterThanOrEqualTest < Minitest::Test
  def test_integers
    pred = Predicator::Predicates::GreaterThanOrEqual.new 2, 1
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThanOrEqual.new 2, 2
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThanOrEqual.new 2, 3
    refute pred.satisfied?
  end

  def test_floats
    pred = Predicator::Predicates::GreaterThanOrEqual.new 2.0, 1.0
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThanOrEqual.new 2.0, 2.0
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThanOrEqual.new 2.0, 3.0
    refute pred.satisfied?
  end

  def test_strings
    pred = Predicator::Predicates::GreaterThanOrEqual.new "foo", "bar"
    assert pred.satisfied?
  end

  def test_dates
    date1 = Date.new 2016, 01, 02
    date2 = Date.new 2016, 01, 03

    pred = Predicator::Predicates::GreaterThanOrEqual.new date1, date1
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThanOrEqual.new date2, date1
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThanOrEqual.new date1, date2
    refute pred.satisfied?
  end
end
