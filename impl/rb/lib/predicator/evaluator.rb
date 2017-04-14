module Predicator
  class Evaluator
    attr_reader :instructions, :stack, :context

    def initialize instructions, context_data={}
      @instructions = instructions
      @context = Context.new context_data
      @stack = []
      @ip = 0
    end

    def result
      while @ip < instructions.length
        process @instructions[@ip]
        @ip += 1
      end
      stack.pop
    end

    def process instruction
      case instruction[:op]
      when "label"
        # no-op
      when "not"
        stack.push !stack.pop
      when "jump_if_false"
        jump_if_false instruction[:to]
      when "jump_if_true"
        jump_if_true instruction[:to]
      when "lit"
        stack.push instruction[:lit]
      when "read_var"
        stack.push context[instruction[:var]]
      when "compare"
        compare instruction[:comparison]
      end
    end

    def jump_if_false new_pointer
      if stack[-1] == false
        @ip = new_pointer
      else
        stack.pop
      end
    end

    def jump_if_true new_pointer
      if stack[-1] == true
        @ip = new_pointer
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
