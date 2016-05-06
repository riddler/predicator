module Predicator
  module Predicates
    class Method
      attr_reader :value, :method

      def initialize value, method
        @value = value
        @method = method
      end

      def satisfied? context=Predicator::Context.new
        node = context.node_for value
        node.send method
      end
    end
  end
end
