module Predicator
  module Visitors
    class Instructions < Visitor
      attr_reader :instructions

      def initialize instructions=[]
        @instructions = instructions
        @labels = {}
      end

      def accept ast
        super
        process_labels
        update_jumps
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
          label: node.object_id.to_s
        }
      end

      def label_instruction node
        {
          op: "label",
          label: node.object_id.to_s
        }
      end

      def process_labels
        @instructions.each_with_index do |inst, idx|
          next unless inst[:op] == "label"
          @labels[inst[:label]] = idx
        end
      end

      def update_jumps
        @instructions.each_with_index do |inst, idx|
          next unless inst[:op] =~ /^jump/
          inst[:to] = @labels[inst.delete :label]
        end
      end
    end
  end
end
