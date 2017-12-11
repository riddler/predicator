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

      def visit_NOT node;   visit_children node; end
      def visit_GROUP node; visit_children node; end
      def visit_BOOL node;  visit_children node; end

      def visit_INTEQ node;      visit_children node; end
      def visit_INTGT node;      visit_children node; end
      def visit_INTLT node;      visit_children node; end
      def visit_INTIN node;      visit_children node; end
      def visit_INTNOTIN node;   visit_children node; end
      def visit_INTBETWEEN node; visit_children node; end

      def visit_STREQ node;    visit_children node; end
      def visit_STRGT node;    visit_children node; end
      def visit_STRLT node;    visit_children node; end
      def visit_STRIN node;    visit_children node; end
      def visit_STRNOTIN node; visit_children node; end

      def visit_AND node;   visit_children node; end
      def visit_OR node;    visit_children node; end

      def terminal node; end
      def visit_TRUE node;      terminal node; end
      def visit_FALSE node;     terminal node; end
      def visit_INTEGER node;   terminal node; end
      def visit_STRING node;    terminal node; end
      def visit_VARIABLE node;  terminal node; end

      def visit_INTARRAY node
        node.left.each{ |item| visit item }
      end

      def visit_STRARRAY node
        node.left.each{ |item| visit item }
      end
    end
  end
end
