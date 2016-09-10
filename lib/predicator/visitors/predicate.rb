module Predicator
  module Visitors
    class Predicate < Visitor
      private

      def visit_TRUE node
        Predicates::True.new
      end

      def visit_FALSE node
        Predicates::False.new
      end

      def visit_NOT node
        Predicates::Not.new visit(node.left)
      end
    end
  end
end
