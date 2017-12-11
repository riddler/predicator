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

      def visit_INTEQ node
        super
        @instructions.push ["compare", "INTEQ"]
      end

      def visit_STREQ node
        super
        @instructions.push ["compare", "STREQ"]
      end

      def visit_INTGT node
        super
        @instructions.push ["compare", "INTGT"]
      end

      def visit_STRGT node
        super
        @instructions.push ["compare", "STRGT"]
      end

      def visit_INTLT node
        super
        @instructions.push ["compare", "INTLT"]
      end

      def visit_STRLT node
        super
        @instructions.push ["compare", "STRLT"]
      end

      def visit_INTBETWEEN node
        super
        @instructions.push ["compare", "INTBETWEEN"]
      end

      def visit_INTIN node
        super
        @instructions.push ["compare", "INTIN"]
      end

      def visit_STRIN node
        super
        @instructions.push ["compare", "STRIN"]
      end

      def visit_INTNOTIN node
        super
        @instructions.push ["compare", "INTNOTIN"]
      end

      def visit_STRNOTIN node
        super
        @instructions.push ["compare", "STRNOTIN"]
      end

      def visit_INTARRAY node
        contents = node.left.map{ |item| item.left }
        @instructions.push ["integer_array", contents]
      end

      def visit_STRARRAY node
        contents = node.left.map{ |item| item.left }
        @instructions.push ["string_array", contents]
      end

      def visit_VARIABLE node
        @instructions.push ["load", node.symbol]
      end

      def visit_BOOL node
        super
        @instructions.push ["to_bool"]
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
          offset = calculate_offset idx, @label_locations[label]
          inst.push offset
        end
      end

      def calculate_offset from_idx, to_idx
        offset = to_idx - from_idx
        num_labels = @instructions[from_idx...to_idx].count{ |i| i.first == "label" }
        offset - num_labels
      end

      def remove_labels
        @instructions.delete_if{ |inst| inst.first == "label" }
      end
    end
  end
end
