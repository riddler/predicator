module Predicator
  module Visitors
    class Visitor
      DISPATCH_CACHE = Hash.new { |h,k|
        h[k] = "visit_#{k}"
      }

      def accept node
        visit node
      end

      private

      def visit node
        send DISPATCH_CACHE[node.type], node
      end

      def unary node
        visit node.left
      end
      def visit_NOT node;   unary node; end
      def visit_GROUP node; unary node; end

      def binary node
        visit node.left
        visit node.right
      end
      def visit_EQ node;    binary node; end
      def visit_GT node;    binary node; end
      def visit_AND node;   binary node; end
      def visit_OR node;    binary node; end

      def terminal node; end
      def visit_TRUE node;      terminal node; end
      def visit_FALSE node;     terminal node; end
      def visit_INTEGER node;   terminal node; end
      def visit_STRING node;    terminal node; end
      def visit_VARIABLE node;  terminal node; end
      def visit_NAMED node;     terminal node; end
    end
  end
end
