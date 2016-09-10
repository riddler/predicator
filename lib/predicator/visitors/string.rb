module Predicator
  module Visitors
    class String < Visitor
      private

      def terminal node
        node.left.to_s
      end

      def visit_NOT node
        "!#{visit node.left}"
      end

      def visit_STRING node
        "'#{node.left}'"
      end

      def visit_GROUP node
        "(#{visit node.left})"
      end

      def visit_EQUAL node
        [visit(node.left), " = ", visit(node.right)].join
      end

      def visit_AND node
        [visit(node.left), " and ", visit(node.right)].join
      end

      def visit_OR node
        [visit(node.left), " or ", visit(node.right)].join
      end
    end
  end
end
