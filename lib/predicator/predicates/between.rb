module Predicator
  module Predicates
    class Between
      attr_reader :value, :left, :right

      def initialize value, left, right
        @value, @left, @right = value, left, right
      end

      def satisfied? context=Predicator::Context.new
        value_node = context.node_for value
        left_node = context.node_for left
        right_node = context.node_for right
        method = "compare_to_#{value_node.type}"

        left_value = left_node.send method
        right_value = right_node.send method

        (value_node.value >= left_value) &&
          (value_node.value <= right_value)
      end

      def == other
        other.kind_of?(self.class) &&
          other.value == value &&
          other.left == left &&
          other.right == right
      end
    end
  end
end
