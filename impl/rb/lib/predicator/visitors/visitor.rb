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

      def visit_children node
        node.children.each {|child| visit child}
      end

      def unary node
        visit node.left
      end
      def visit_NOT node;   visit_children node; end
      def visit_GROUP node; visit_children node; end

      def binary node
        visit node.left
        visit node.right
      end
      def visit_EQ node;    visit_children node; end
      def visit_GT node;    visit_children node; end
      def visit_LT node;    visit_children node; end
      def visit_AND node;   visit_children node; end
      def visit_OR node;    visit_children node; end
      def visit_IN node;    visit_children node; end
      def visit_NOTIN node; visit_children node; end

      def ternary node
        visit node.left
        visit node.middle
        visit node.right
      end
      def visit_BETWEEN node; visit_children node; end

      def terminal node; end
      def visit_TRUE node;      terminal node; end
      def visit_FALSE node;     terminal node; end
      def visit_INTEGER node;   terminal node; end
      def visit_STRING node;    terminal node; end
      def visit_VARIABLE node;  terminal node; end

      def visit_ARRAY node
        node.left.each{ |item| visit item }
      end
    end
  end
end
