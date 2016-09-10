module Predicator
  module Visitors
    class Dot < Visitor
      def initialize
        @nodes = []
        @edges = []
      end

      def accept node
        super
        <<-eodot
digraph parse_tree {
  size="8,5"
  node [shape = none];
  edge [dir = none];
  #{@nodes.join "\n  "}
  #{@edges.join "\n  "}
}
        eodot
      end

      private

      def binary node
        node.children.each do |c|
          @edges << "#{node.object_id} -> #{c.object_id};"
        end
        super
      end

      def unary node
        @edges << "#{node.object_id} -> #{node.left.object_id};"
        super
      end

      def visit_EQUAL node
        @nodes << "#{node.object_id} [label=\"=\"];"
        super
      end

      def visit_AND node
        @nodes << "#{node.object_id} [label=\"and\"];"
        super
      end

      def visit_OR node
        @nodes << "#{node.object_id} [label=\"or\"];"
        super
      end

      def visit_NOT node
        @nodes << "#{node.object_id} [label=\"!\"];"
        super
      end

      def visit_GROUP node
        @nodes << "#{node.object_id} [label=\"( )\"];"
        super
      end

      def visit_STRING node
        value = node.left
        @nodes << "#{node.object_id} [label=\"'#{value}'\"];"
      end

      def terminal node
        value = node.left.to_s
        @nodes << "#{node.object_id} [label=\"#{value}\"];"
      end
    end
  end
end
