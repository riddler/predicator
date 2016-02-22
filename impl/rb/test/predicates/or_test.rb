require_relative "../test_helper"

class OrTest < Minitest::Test
  def test_no_sub_predicates
    predicate = Predicator::Predicates::Or.new []
    refute predicate.satisfied?
  end

  def test_valid_single_sub_predicate
    predicate = Predicator::Predicates::Or.new [Predicator::Predicates::True.new]
    assert predicate.satisfied?
  end

  def test_invalid_single_sub_predicate
    predicate = Predicator::Predicates::Or.new [Predicator::Predicates::False.new]
    refute predicate.satisfied?
  end

  def test_valid_sub_predicates
    predicate = Predicator::Predicates::Or.new [
      Predicator::Predicates::True.new, Predicator::Predicates::True.new]
    assert predicate.satisfied?
  end

  def test_invalid_sub_predicates
    predicate = Predicator::Predicates::Or.new [
      Predicator::Predicates::True.new, Predicator::Predicates::False.new]
    assert predicate.satisfied?
  end
end
