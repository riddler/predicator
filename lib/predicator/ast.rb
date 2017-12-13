module Predicator
  module AST
    class Node
      include Enumerable

      attr_accessor :left

      def initialize left
        @left = left
      end

      def each &block
        Visitors::Each.new(block).accept self
      end

      def to_dot
        Visitors::Dot.new.accept self
      end

      def to_instructions
        Visitors::Instructions.new.accept self
      end

      def to_predicate
        Visitors::Predicate.new.accept self
      end

      def to_s
        Visitors::String.new.accept self
      end

      def type
        raise NotImplementedError
      end

      def variable?; false; end
      def literal?; false; end
    end

    class Terminal < Node
      alias :symbol :left
    end

    class Literal < Terminal
      def type; :LITERAL; end
      def literal?; true; end
    end

    class Variable < Terminal
      def type; :VARIABLE; end
      def variable?; true; end
    end

    %w[ True False Integer String ].each do |t|
      class_eval <<-eoruby, __FILE__, __LINE__ + 1
        class #{t} < Literal;
          def type; :#{t.upcase}; end
        end
      eoruby
    end

    class Unary < Node
      def children; [left] end
    end

    class IntegerArray < Unary
      def type; :INTARRAY; end
    end

    class StringArray < Unary
      def type; :STRARRAY; end
    end

    class Not < Unary
      def type; :NOT; end
    end

    class Group < Unary
      def type; :GROUP; end
    end

    class Binary < Node
      attr_accessor :right

      def initialize left, right
        super left
        @right = right
      end

      def children; [left, right] end
    end

    class IntegerEqual < Binary
      def type; :INTEQ; end
    end

    class StringEqual < Binary
      def type; :STREQ; end
    end

    class IntegerGreaterThan < Binary
      def type; :INTGT; end
    end

    class StringGreaterThan < Binary
      def type; :STRGT; end
    end

    class IntegerLessThan < Binary
      def type; :INTLT; end
    end

    class StringLessThan < Binary
      def type; :STRLT; end
    end

    class IntegerIn < Binary
      def type; :INTIN; end
    end

    class StringIn < Binary
      def type; :STRIN; end
    end

    class IntegerNotIn < Binary
      def type; :INTNOTIN; end
    end

    class StringNotIn < Binary
      def type; :STRNOTIN; end
    end

    class And < Binary
      def type; :AND; end
    end

    class Or < Binary
      def type; :OR; end
    end

    class Ternary < Node
      attr_accessor :middle, :right

      def initialize left, middle, right
        super left
        @middle = middle
        @right = right
      end

      def children; [left, middle, right] end
    end

    class IntegerBetween < Ternary
      def type; :INTBETWEEN; end
    end

    class BooleanVariable < Unary
      def type; :BOOL; end
    end

  end
end
