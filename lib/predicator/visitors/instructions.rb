module Predicator
  module Visitors
    class Instructions < Visitor
      attr_reader :instructions

      def initialize instructions
        @instructions = instructions
      end

      private

      def visit_AND node
        visit node.left
        instructions.push jump_instruction("false", node)
        visit node.right
        instructions.push label_instruction(node)
      end

      def visit_OR node
        visit node.left
        instructions.push jump_instruction("true", node)
        visit node.right
        instructions.push label_instruction(node)
      end

      def visit_EQUAL node
        super
        instructions.push  op: "compare", comparison: "EQ"
      end

      def terminal node
        instructions.push  op: "lit", lit: node.symbol
      end

      def jump_instruction condition, node
        {
          op: "jump_if_#{condition}",
          label: node.object_id.to_s
        }
      end

      def label_instruction node
        {
          op: "label",
          label: node.object_id.to_s
        }
      end
    end
  end
end
