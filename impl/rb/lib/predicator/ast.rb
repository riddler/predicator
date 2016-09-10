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
        instructions = []
        Visitors::Instructions.new(instructions).accept self
        instructions
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
    end

    class Terminal < Node
      alias :symbol :left
    end

    #class Literal < Terminal
    #  def type; :LITERAL; end
    #end

    class Variable < Terminal
      def type; :VARIABLE; end
      def variable?; true; end
    end

    %w[ True False Integer String ].each do |t|
      class_eval <<-eoruby, __FILE__, __LINE__ + 1
        class #{t} < Terminal;
          def type; :#{t.upcase}; end
        end
      eoruby
    end

    class Unary < Node
      def children; [left] end
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

    class Equal < Binary
      def type; :EQUAL; end
    end

    class And < Binary
      def type; :AND; end
    end

    class Or < Binary
      def type; :OR; end
    end

  end
end
