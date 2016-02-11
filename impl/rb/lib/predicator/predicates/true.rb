module Predicator
  module Predicates
    class True
      def satisfied? context=Context.new
        true
      end

      def == other
        other.kind_of? self.class
      end
    end
  end
end
