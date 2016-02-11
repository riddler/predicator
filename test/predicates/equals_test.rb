require_relative "../test_helper"

module Predicator::Predicates
  class EqualsTest < Minitest::Test
    def test_integer_equals
      predicate = Equals.new 1, 1
      assert predicate.satisfied?
    end
  end
end
