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
        @instructions.push ["not"]
      end

      def visit_EQ node
        super
        @instructions.push ["compare", "EQ"]
      end

      def visit_GT node
        super
        @instructions.push ["compare", "GT"]
      end

      def visit_VARIABLE node
        @instructions.push ["load", node.symbol]
      end

      def terminal node
        @instructions.push ["lit", node.symbol]
      end

      def jump_instruction condition, node
        ["j#{condition}", node.object_id.to_s]
      end

      def label_instruction node
        label = node.object_id.to_s
        @label_locations[label] = @instructions.size
        ["label", label]
      end

      def update_jumps
        @instructions.each_with_index do |inst, idx|
          next unless inst.first =~ /^j/
          label = inst.pop
          offset = @label_locations[label] - idx
          inst.push offset
        end
      end

      def remove_labels
        @instructions.delete_if{ |inst| inst.first == "label" }
      end
    end
  end
end
