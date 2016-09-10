module Predicator
  module Predicates

    class False
      def satisfied? context=Context.new
        false
      end
    end

  end
end
