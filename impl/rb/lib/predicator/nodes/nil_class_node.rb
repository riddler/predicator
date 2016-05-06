module Predicator
  module Nodes
    class NilClassNode < BaseNode
      def type
        :nil
      end

      def compare_to_date
        raise NilValueError
      end

      def compare_to_fixnum
        raise NilValueError
      end

      def compare_to_float
        raise NilValueError
      end

      def compare_to_string
        raise NilValueError
      end
    end
  end
end
