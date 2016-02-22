require_relative "../test_helper"

class NotTest < Minitest::Test
  def test_not_true
    predicate = Predicator::Predicates::Not.new Predicator::Predicates::True.new
    refute predicate.satisfied?
  end

  def test_not_false
    predicate = Predicator::Predicates::Not.new Predicator::Predicates::False.new
    assert predicate.satisfied?
  end
end
