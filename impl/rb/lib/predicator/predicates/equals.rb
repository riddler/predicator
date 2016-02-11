module Predicator
  module Predicates
    class Equals
      attr_reader :left, :right

      def initialize left, right
        @left, @right = left, right
      end

      def satisfied? context=Context.new
        context.value_for(left) == context.value_for(right)
      end

      def == other
        other.kind_of?(self.class) &&
          other.left == left &&
          other.right == right
      end
    end
  end
end
