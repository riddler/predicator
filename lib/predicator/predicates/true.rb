module Predicator
  module Predicates

    class True
      def satisfied? context=Context.new
        true
      end
    end

  end
end
