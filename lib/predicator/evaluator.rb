module Predicator
  class Evaluator
    attr_reader :instructions, :stack, :context

    def initialize instructions, context_data={}
      @instructions = instructions
      @context = context_for context_data
      @stack = []
      @ip = 0
    end

    def context_for context_data
      return context_data unless context_data.kind_of? Hash
      Context.new context_data
    end

    def result
      while @ip < instructions.length
        process @instructions[@ip]
        @ip += 1
      end
      stack.pop
    end

    def process instruction
      case instruction.first
      when "not"
        stack.push !stack.pop
      when "jfalse"
        jump_if_false instruction.last
      when "jtrue"
        jump_if_true instruction.last
      when "lit"
        stack.push instruction.last
      when "load"
        stack.push context[instruction.last]
      when "compare"
        compare instruction.last
      end
    end

    def jump_if_false offset
      if stack[-1] == false
        adjusted_offset = offset - 1
        @ip += adjusted_offset
      else
        stack.pop
      end
    end

    def jump_if_true offset
      if stack[-1] == true
        adjusted_offset = offset - 1
        @ip += adjusted_offset
      else
        stack.pop
      end
    end

    def compare comparison
      right = stack.pop
      left = stack.pop
      if left.nil? || right.nil?
        stack.push false
      else
        stack.push send("compare_#{comparison}", left, right)
      end
    end

    def compare_EQ left, right
      left == right
    end

    def compare_GT left, right
      left > right
    end
  end
end