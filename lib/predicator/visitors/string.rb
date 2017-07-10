module Predicator
  module Visitors
    class String < Visitor
      private

      def terminal node
        node.left.to_s
      end

      def visit_STRING node
        "'#{node.left}'"
      end

      def visit_ARRAY node
        contents = node.left.map{ |item| visit item }.join(", ")
        "[#{contents}]"
      end

      def visit_NOT node
        "!#{visit node.left}"
      end

      def visit_GROUP node
        "(#{visit node.left})"
      end

      def visit_EQ node
        [visit(node.left), " = ", visit(node.right)].join
      end

      def visit_GT node
        [visit(node.left), " > ", visit(node.right)].join
      end

      def visit_LT node
        [visit(node.left), " < ", visit(node.right)].join
      end

      def visit_AND node
        [visit(node.left), " and ", visit(node.right)].join
      end

      def visit_OR node
        [visit(node.left), " or ", visit(node.right)].join
      end

      def visit_BETWEEN node
        [visit(node.left), " between ", visit(node.middle), " and ", visit(node.right)].join
      end

      def visit_IN node
        [visit(node.left), " in ", visit(node.right)].join
      end

      def visit_NOTIN node
        [visit(node.left), " not in ", visit(node.right)].join
      end
    end
  end
end
