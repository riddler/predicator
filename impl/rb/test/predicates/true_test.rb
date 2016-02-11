require_relative "../test_helper"

module Predicator::Predicates
  class TrueTest < Minitest::Test
    def test_satisfied
      predicate = True.new
      assert predicate.satisfied?
    end
  end
end
