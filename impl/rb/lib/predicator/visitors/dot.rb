module Predicator
  module Visitors
    class Dot < Visitor
      attr_reader :nodes, :edges

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

      def visit_children node
        node.children.each do |c|
          @edges << "#{node.object_id} -> #{c.object_id};"
        end
        super
      end

      def visit_EQ node
        @nodes << "#{node.object_id} [label=\"=\"];"
        super
      end

      def visit_GT node
        @nodes << "#{node.object_id} [label=\">\"];"
        super
      end

      def visit_LT node
        @nodes << "#{node.object_id} [label=\"<\"];"
        super
      end

      def visit_BETWEEN node
        @nodes << "#{node.object_id} [label=\"between\"];"
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

      def visit_DATEAGO node
        @nodes << "#{node.object_id} [label=\"ago\"];"
        super
      end

      def visit_DATEFROMNOW node
        @nodes << "#{node.object_id} [label=\"from now\"];"
        super
      end

      def visit_STRENDSWITH node
        @nodes << "#{node.object_id} [label=\"ends with\"];"
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

      def add_source source, parent
        ast = Predicator.parse source
        vis = Dot.new
        vis.accept ast
        @nodes += vis.nodes
        @edges += vis.edges
        @edges << "#{parent.object_id} -> #{ast.object_id};"
      end
    end
  end
end
