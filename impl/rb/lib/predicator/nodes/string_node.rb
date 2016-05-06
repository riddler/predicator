module Predicator
  module Nodes
    class StringNode < BaseNode
      def type
        :string
      end

      def compare_to_date
        Date.parse value
      end
    end
  end
end
