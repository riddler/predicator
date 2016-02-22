require_relative "../test_helper"

class TrueTest < Minitest::Test
  def test_true_predicate
    pred = Predicator::Predicates::True.new
    assert pred.satisfied?
  end
end
