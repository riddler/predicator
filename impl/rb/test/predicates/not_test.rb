require_relative "../test_helper"

module Predicator::Predicates
  class NotTest < Minitest::Test
    def test_not_true
      predicate = Not.new True.new
      refute predicate.satisfied?
    end

    def test_not_false
      predicate = Not.new False.new
      assert predicate.satisfied?
    end
  end
end
