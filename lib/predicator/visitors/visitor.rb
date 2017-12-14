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

      def visit_NOT node;          visit_children node; end
      def visit_GROUP node;        visit_children node; end
      def visit_BOOL node;         visit_children node; end
      def visit_DATEAGO node;      visit_children node; end
      def visit_DATEFROMNOW node;  visit_children node; end

      def visit_INTEQ node;        visit_children node; end
      alias_method :visit_STREQ, :visit_INTEQ
      alias_method :visit_DATEQ, :visit_INTEQ

      def visit_INTGT node;        visit_children node; end
      alias_method :visit_STRGT, :visit_INTGT
      alias_method :visit_DATGT, :visit_INTGT

      def visit_INTLT node;        visit_children node; end
      alias_method :visit_STRLT, :visit_INTLT
      alias_method :visit_DATLT, :visit_INTLT

      def visit_INTIN node;        visit_children node; end
      alias_method :visit_STRIN, :visit_INTIN

      def visit_INTNOTIN node;     visit_children node; end
      alias_method :visit_STRNOTIN, :visit_INTNOTIN

      def visit_INTBETWEEN node;   visit_children node; end
      alias_method :visit_DATBETWEEN, :visit_INTBETWEEN

      def visit_AND node;          visit_children node; end
      def visit_OR node;           visit_children node; end

      def terminal node; end
      def visit_TRUE node;      terminal node; end
      def visit_FALSE node;     terminal node; end

      def visit_DATE node;      terminal node; end
      def visit_DURATION node;  terminal node; end

      def visit_INTEGER node;   terminal node; end
      def visit_STRING node;    terminal node; end
      def visit_VARIABLE node;  terminal node; end

      def visit_BLANK node;     terminal node; end
      def visit_PRESENT node;   terminal node; end

      def visit_INTARRAY node
        node.left.each{ |item| visit item }
      end
      alias_method :visit_STRARRAY, :visit_INTARRAY
    end
  end
end
