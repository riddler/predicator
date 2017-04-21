module Predicator
  module Visitors
    class Instructions < Visitor
      attr_reader :instructions

      def initialize instructions=[]
        @instructions = instructions
        @label_locations = {}
      end

      def accept ast
        super
        # Keep track of instruction location, add it to the label instruction
        # Remove labels - no need for evaluator to see them
        update_jumps
        remove_labels
        @instructions
      end

      private

      def visit_AND node
        visit node.left
        @instructions.push jump_instruction("false", node)
        visit node.right
        @instructions.push label_instruction(node)
      end

      def visit_OR node
        visit node.left
        @instructions.push jump_instruction("true", node)
        visit node.right
        @instructions.push label_instruction(node)
      end

      def visit_NOT node
        super
        @instructions.push op: "not"
      end

      def visit_EQ node
        super
        @instructions.push op: "compare", comparison: "EQ"
      end

      def visit_GT node
        super
        @instructions.push op: "compare", comparison: "GT"
      end

      def visit_VARIABLE node
        @instructions.push op: "read_var", var: node.symbol
      end

      def terminal node
        @instructions.push op: "lit", lit: node.symbol
      end

      def jump_instruction condition, node
        {
          op: "jump_if_#{condition}",
          label: node.object_id.to_s,
        }
      end

      def label_instruction node
        label = node.object_id.to_s
        @label_locations[label] = @instructions.size
        {
          op: "label",
          label: label
        }
      end

      def update_jumps
        @instructions.each_with_index do |inst, idx|
          next unless inst[:op] =~ /^jump/
          label = inst.delete :label
          offset = @label_locations[label] - idx
          inst[:offset] = offset
        end
      end

      def remove_labels
        @instructions.delete_if{ |inst| inst[:op] == "label" }
      end
    end
  end
end
