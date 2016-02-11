require_relative "../test_helper"

module Predicator::Predicates
  class OrTest < Minitest::Test
    def test_no_sub_predicates
      predicate = Or.new []
      refute predicate.satisfied?
    end

    def test_valid_single_sub_predicate
      predicate = Or.new [Equals.new(1, 1)]
      assert predicate.satisfied?
    end

    def test_invalid_single_sub_predicate
      predicate = Or.new [Equals.new(1, 2)]
      refute predicate.satisfied?
    end

    def test_valid_sub_predicates
      predicate = Or.new [Equals.new(1, 1), Equals.new(2, 2)]
      assert predicate.satisfied?
    end

    def test_single_invalid_sub_predicate
      predicate = Or.new [Equals.new(1, 2), Equals.new(2, 2)]
      assert predicate.satisfied?
    end

    def test_multiple_invalid_sub_predicates
      predicate = Or.new [Equals.new(1, 2), Equals.new(2, 3)]
      refute predicate.satisfied?
    end
  end
end
