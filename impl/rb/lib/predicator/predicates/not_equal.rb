module Predicator
  module Predicates
    class NotEqual < Predicator::Predicates::Relation
      def satisfied? context=Predicator::Context.new
        context.value_for(left) != context.value_for(right)
      end
    end
  end
end
