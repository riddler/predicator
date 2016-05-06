module Predicator
  module Nodes
    class BaseNode
      attr_reader :value

      def self.class_for value
        class_name = "#{value.class.name}Node"
        if ::Predicator::Nodes.const_defined? class_name
          ::Predicator::Nodes.const_get class_name
        else
          raise UnknownNodeTypeError, "Unknown node type for #{value.class} (#{value.inspect})"
        end
      end

      def initialize value
        @value = value
      end

      def blank?
        value.respond_to?(:empty?) ?
          !!value.empty? :
          !value
      end

      def present?
        !blank?
      end

      def comparison_method
        "compare_to_#{type}"
      end

      def compare_to_nil
        raise NilValueError
      end

      #def compare_to_date
      #end

      def compare_to_fixnum
        value.to_i
      end

      def compare_to_float
        value.to_f
      end

      def compare_to_string
        value.to_s
      end
    end
  end
end
