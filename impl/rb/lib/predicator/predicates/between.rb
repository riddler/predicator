module Predicator
  module Predicates
    class Between
      attr_reader :value, :left, :right

      def initialize value, left, right
        @value, @left, @right = value, left, right
      end

      def satisfied? context=Predicator::Context.new
        context.value_for(value) >= context.value_for(left) &&
          context.value_for(value) <= context.value_for(right)
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
