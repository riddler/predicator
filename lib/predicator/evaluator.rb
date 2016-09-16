module Predicator
  class Evaluator
    attr_reader :instructions, :stack, :context

    def initialize instructions, context_data={}
      @instructions = instructions
      @context = Context.new context_data
      @stack = []
      @ip = 0
      process_labels
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
        jump_if_false instruction[:label]
      when "jump_if_true"
        jump_if_true instruction[:label]
      when "lit"
        stack.push instruction[:lit]
      when "read_var"
        stack.push context[instruction[:var]]
      when "compare"
        compare instruction[:comparison]
      end
    end

    def jump_if_false label
      if stack[-1] == false
        @ip = @labels[label]
      else
        stack.pop
      end
    end

    def jump_if_true label
      if stack[-1] == true
        @ip = @labels[label]
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

    # Build up a map of label => instruction_pointer
    def process_labels
      @labels = {}
      @instructions.each_with_index do |inst, idx|
        next unless inst[:op] == "label"
        @labels[inst[:label]] = idx
      end
    end
  end
end
