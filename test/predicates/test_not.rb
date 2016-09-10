require "helper"

module Predicator
  module Predicates
    class TestNot < Minitest::Test
      def test_not
        pred = Not.new True.new
        refute pred.satisfied?
      end
    end
  end
end
