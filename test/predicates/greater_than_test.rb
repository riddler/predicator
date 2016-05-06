require_relative "../test_helper"

class GreaterThanTest < Minitest::Test
  def test_integers
    pred = Predicator::Predicates::GreaterThan.new 2, 1
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThan.new 2, 2
    refute pred.satisfied?

    pred = Predicator::Predicates::GreaterThan.new 2, 3
    refute pred.satisfied?
  end

  def test_floats
    pred = Predicator::Predicates::GreaterThan.new 2.0, 1.0
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThan.new 2.0, 2.0
    refute pred.satisfied?

    pred = Predicator::Predicates::GreaterThan.new 2.0, 3.0
    refute pred.satisfied?
  end

  def test_strings
    pred = Predicator::Predicates::GreaterThan.new "b", "a"
    assert pred.satisfied?
  end

  def test_float_greater_than_integer
    pred = Predicator::Predicates::GreaterThan.new 2.1, 2
    assert pred.satisfied?
  end

  def test_integer_greater_than_float
    pred = Predicator::Predicates::GreaterThan.new 2, 1.0
    assert pred.satisfied?
  end

  def test_float_greater_than_string
    pred = Predicator::Predicates::GreaterThan.new 2.1, "2.0"
    assert pred.satisfied?
  end

  def test_string_greater_than_float
    pred = Predicator::Predicates::GreaterThan.new "2.1", 2.0
    assert pred.satisfied?
  end

  def test_integer_greater_than_string
    pred = Predicator::Predicates::GreaterThan.new 2, "1"
    assert pred.satisfied?
  end

  def test_string_greater_than_integer
    pred = Predicator::Predicates::GreaterThan.new "2", 1
    assert pred.satisfied?
  end

  def test_dates
    date1 = Date.new 2016, 01, 02
    date2 = Date.new 2016, 01, 03

    pred = Predicator::Predicates::GreaterThan.new date1, date1
    refute pred.satisfied?

    pred = Predicator::Predicates::GreaterThan.new date2, date1
    assert pred.satisfied?

    pred = Predicator::Predicates::GreaterThan.new date1, date2
    refute pred.satisfied?
  end

  def test_date_greater_than_string
    date = Date.new 2016, 01, 02
    pred = Predicator::Predicates::GreaterThan.new date, "2016/01/01"
    assert pred.satisfied?
  end

  def test_string_greater_than_date
    date = Date.new 2016, 01, 02
    pred = Predicator::Predicates::GreaterThan.new "2016/01/03", date
    assert pred.satisfied?
  end

  def test_nil_greater_than_integer
    pred = Predicator::Predicates::GreaterThan.new nil, 1
    refute pred.satisfied?
  end
end
