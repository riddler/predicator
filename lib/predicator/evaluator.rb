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
      when "lit", "array"
        stack.push instruction.last
      when "load"
        stack.push context[instruction.last]
      when "to_bool"
        stack.push !!stack.pop
      when "to_int"
        stack.push to_int(stack.pop)
      when "to_str"
        stack.push to_str(stack.pop)
      when "compare"
        if instruction.last == "BETWEEN"
          compare_BETWEEN
        else
          compare instruction.last
        end
      end
    end

    def to_int val
      if val.nil? || (val.is_a?(String) && val.empty?)
        nil
      else
        val.to_i
      end
    end

    def to_str val
      val.nil? ? nil : val.to_s
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
    rescue
      stack.push false
    end

    def compare_EQ left, right
      left == right
    end

    def compare_GT left, right
      left > right
    end

    def compare_LT left, right
      left < right
    end

    def compare_IN left, right
      right.include? left
    end

    def compare_NOTIN left, right
      !right.include? left
    end

    def compare_BETWEEN
      max = stack.pop
      min = stack.pop
      val = stack.pop
      if max.nil? || min.nil? || val.nil?
        stack.push false
      else
        result = val.between? min, max
        stack.push result
      end
    rescue
      stack.push false
    end
  end
end
