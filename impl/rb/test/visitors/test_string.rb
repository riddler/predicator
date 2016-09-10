require "helper"

module Predicator
  module Visitors
    class TestString < Minitest::Test
      def setup
        @parser = Parser.new
      end

      def test_true
        ast = AST::True.new "true"
        assert_equal "true", ast.to_s
      end
    end
  end
end
