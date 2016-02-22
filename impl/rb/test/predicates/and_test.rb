require_relative "../test_helper"

class AndTest < Minitest::Test
  def test_no_sub_predicates
    predicate = Predicator::Predicates::And.new []
    assert predicate.satisfied?
  end

  def test_valid_single_sub_predicate
    predicate = Predicator::Predicates::And.new [Predicator::Predicates::True.new]
    assert predicate.satisfied?
  end

  def test_invalid_single_sub_predicate
    predicate = Predicator::Predicates::And.new [Predicator::Predicates::False.new]
    refute predicate.satisfied?
  end

  def test_valid_sub_predicates
    predicate = Predicator::Predicates::And.new [
      Predicator::Predicates::True.new, Predicator::Predicates::True.new]
    assert predicate.satisfied?
  end

  def test_invalid_sub_predicates
    predicate = Predicator::Predicates::And.new [
      Predicator::Predicates::True.new, Predicator::Predicates::False.new]
    refute predicate.satisfied?
  end
end
