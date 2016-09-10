require "helper"

module Predicator
  module Predicates
    class TestFalse < Minitest::Test
      def test_false
        pred = False.new
        refute pred.satisfied?
      end
    end
  end
end
