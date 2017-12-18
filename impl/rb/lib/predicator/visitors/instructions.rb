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
        visit node.left
        add_typecast_to_instructions node
        visit node.right
        @instructions.push ["compare", "EQ"]
      end
      alias_method :visit_STREQ, :visit_INTEQ
      alias_method :visit_DATEQ, :visit_INTEQ


      def visit_INTGT node
        visit node.left
        add_typecast_to_instructions node
        visit node.right
        @instructions.push ["compare", "GT"]
      end
      alias_method :visit_STRGT, :visit_INTGT
      alias_method :visit_DATGT, :visit_INTGT

      def visit_INTLT node
        visit node.left
        add_typecast_to_instructions node
        visit node.right
        @instructions.push ["compare", "LT"]
      end
      alias_method :visit_STRLT, :visit_INTLT
      alias_method :visit_DATLT, :visit_INTLT

      def visit_INTBETWEEN node
        visit node.left
        add_typecast_to_instructions node
        visit node.middle
        visit node.right
        @instructions.push ["compare", "BETWEEN"]
      end
      alias_method :visit_DATBETWEEN, :visit_INTBETWEEN

      def visit_INTIN node
        visit node.left
        add_typecast_to_instructions node
        visit node.right
        @instructions.push ["compare", "IN"]
      end
      alias_method :visit_STRIN, :visit_INTIN

      def visit_INTNOTIN node
        visit node.left
        add_typecast_to_instructions node
        visit node.right
        @instructions.push ["compare", "NOTIN"]
      end
      alias_method :visit_STRNOTIN, :visit_INTNOTIN

      def visit_INTARRAY node
        contents = node.left.map{ |item| item.left }
        @instructions.push ["array", contents]
      end
      alias_method :visit_STRARRAY, :visit_INTARRAY

      def visit_VARIABLE node
        @instructions.push ["load", node.symbol]
      end

      def visit_BOOL node
        super
        @instructions.push ["to_bool"]
      end

      def visit_DATE node
        @instructions.push ["lit", node.symbol]
        @instructions.push ["to_date"]
      end

      def visit_DATEAGO node
        visit node.left
        @instructions.push ["ago"]
      end

      def visit_DATEFROMNOW node
        visit node.left
        @instructions.push ["from_now"]
      end

      def visit_DURATION node
        as_seconds = node.symbol.to_i * 24 * 60 * 60
        @instructions.push ["lit", as_seconds]
      end

      def visit_BLANK node
        visit node.left
        @instructions.push ["blank"]
      end

      def visit_PRESENT node
        visit node.left
        @instructions.push ["present"]
      end

      def terminal node
        @instructions.push ["lit", node.symbol]
      end

      def add_typecast_to_instructions node
        type = case node.right.type.to_s
               when /INT/  then "to_int"
               when /STR/  then "to_str"
               when /DATE/ then "to_date"
               end
        @instructions.push [type]
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
          next unless inst.first.match? /^j/
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
