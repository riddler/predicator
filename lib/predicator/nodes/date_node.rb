module Predicator
  module Nodes
    class DateNode < BaseNode
      def type
        :date
      end

      def compare_to_date
        value
      end
    end
  end
end
