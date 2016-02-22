require_relative "../test_helper"

class FalseTest < Minitest::Test
  def test_false_predicate
    pred = Predicator::Predicates::False.new
    refute pred.satisfied?
  end
end
