module Predicator
  module Predicates
    class Relation
      attr_reader :left, :right

      def initialize left, right
        @left, @right = left, right
      end

      def satisfied? context=Predicator::Context.new
        lhs, rhs = values_for_comparison context
        compare_values lhs, rhs
      rescue NilValueError
        return false
      end

      def values_for_comparison context=Context.new
        left_node = context.node_for left
        right_node = context.node_for right
        method = "compare_to_#{left_node.type}"
        [left_node.value, right_node.send(method)]
      end

      def == other
        other.kind_of?(self.class) &&
          other.left == left &&
          other.right == right
      end
    end
  end
end
