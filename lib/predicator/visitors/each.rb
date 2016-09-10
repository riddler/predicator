module Predicator
  module Visitors
    class Each < Visitor
      attr_reader :block

      def initialize block
        @block = block
      end

      def visit node
        super
        block.call node
      end
    end
  end
end
