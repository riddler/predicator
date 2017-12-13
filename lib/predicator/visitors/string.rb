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

      def visit_INTARRAY node
        contents = node.left.map{ |item| visit item }.join(", ")
        "[#{contents}]"
      end
      alias_method :visit_STRARRAY, :visit_INTARRAY

      def visit_NOT node
        "!#{visit node.left}"
      end

      def visit_GROUP node
        "(#{visit node.left})"
      end

      def visit_INTEQ node
        [visit(node.left), " = ", visit(node.right)].join
      end
      alias_method :visit_STREQ, :visit_INTEQ

      def visit_INTGT node
        [visit(node.left), " > ", visit(node.right)].join
      end
      alias_method :visit_STRGT, :visit_INTGT

      def visit_INTLT node
        [visit(node.left), " < ", visit(node.right)].join
      end
      alias_method :visit_STRLT, :visit_INTLT

      def visit_AND node
        [visit(node.left), " and ", visit(node.right)].join
      end

      def visit_OR node
        [visit(node.left), " or ", visit(node.right)].join
      end

      def visit_INTBETWEEN node
        [visit(node.left), " between ", visit(node.middle), " and ", visit(node.right)].join
      end

      def visit_INTIN node
        [visit(node.left), " in ", visit(node.right)].join
      end
      alias_method :visit_STRIN, :visit_INTIN

      def visit_INTNOTIN node
        [visit(node.left), " not in ", visit(node.right)].join
      end
      alias_method :visit_STRNOTIN, :visit_INTNOTIN
    end
  end
end
