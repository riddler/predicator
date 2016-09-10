require "helper"

module Predicator
  module Predicates
    class TestTrue < Minitest::Test
      def test_true
        pred = True.new
        assert pred.satisfied?
      end
    end
  end
end
