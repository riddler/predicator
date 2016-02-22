require_relative "../test_helper"

class BetweenTest < Minitest::Test
  def test_integer_between
    pred = Predicator::Predicates::Between.new 2, 1, 3
    assert pred.satisfied?
  end

  def test_integer_beginning
    pred = Predicator::Predicates::Between.new 1, 1, 3
    assert pred.satisfied?
  end

  def test_integer_end
    pred = Predicator::Predicates::Between.new 3, 1, 3
    assert pred.satisfied?
  end

  def test_dates
    test_date = Date.new 2016, 01, 02
    date1 = Date.new 2016, 01, 01
    date2 = Date.new 2016, 01, 03

    pred = Predicator::Predicates::Between.new test_date, date1, date2
    assert pred.satisfied?
  end
end
