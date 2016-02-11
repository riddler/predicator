require_relative "../test_helper"

module Predicator::Predicates
  class FalseTest < Minitest::Test
    def test_satisfied
      predicate = False.new
      refute predicate.satisfied?
    end
  end
end
