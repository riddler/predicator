require_relative "../test_helper"

class RelationTest < Minitest::Test
  def test_nil_values_for_comparison
    predicate = Predicator::Predicates::Relation.new 1, nil

    assert_raises Predicator::NilValueError do
      predicate.values_for_comparison
    end
  end
end
