require_relative "../test_helper"

module Predicator::Predicates
  class AndTest < Minitest::Test
    def test_no_sub_predicates
      predicate = And.new []
      assert predicate.satisfied?
    end

    def test_valid_single_sub_predicate
      predicate = And.new [Equals.new(1, 1)]
      assert predicate.satisfied?
    end

    def test_invalid_single_sub_predicate
      predicate = And.new [Equals.new(1, 2)]
      refute predicate.satisfied?
    end

    def test_valid_sub_predicates
      predicate = And.new [Equals.new(1, 1), Equals.new(2, 2)]
      assert predicate.satisfied?
    end

    def test_invalid_sub_predicates
      predicate = And.new [Equals.new(1, 2), Equals.new(2, 2)]
      refute predicate.satisfied?
    end
  end
end
