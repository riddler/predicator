require_relative "../test_helper"

module Predicator::Predicates
  class EqualsTest < Minitest::Test
    def test_integer_equals_integer
      predicate = Equals.new 1, 1
      assert predicate.satisfied?
    end

    def test_variable_equals_integer
      context = Predicator::Context.new
      context.bind :favorite, {number:42}

      predicate = Equals.new Predicator::Variable.new("favorite.number"), 42
      assert predicate.satisfied?(context)
    end
  end
end
