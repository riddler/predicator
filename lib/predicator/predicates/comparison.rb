module Predicator
  module Predicates
    class NilValueError < StandardError; end

    class Comparison
      attr_reader :left, :right

      def initialize left, right
        @left = left
        @right = right
      end

      def satisfied? context=Context.new
        compare_values left, right
      end

      def values_for_comparison context=Context.new
      end

      def compare_values
        raise NotImplementedError
      end
    end

  end
end
