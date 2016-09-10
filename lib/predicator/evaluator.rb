module Predicator
  class Evaluator
    attr_reader :instructions, :stack

    def initialize instructions
      @instructions = instructions
      @stack = []
      @ip = 0
      @instruction_count = instructions.length
      @labels = {}
      process_labels
    end

    def result
      while @ip < @instruction_count
        process @instructions[@ip]
        @ip += 1
      end
      stack.pop
    end

    def process instruction
      case instruction[:op]
      when "label"
        # no-op
      when "jump_if_false"
        jump_if_false instruction[:label]
      when "jump_if_true"
        jump_if_true instruction[:label]
      when "lit"
        stack.push instruction[:lit]
      when "compare"
        compare instruction[:comparison]
      end
    end

    def jump_if_false label
      if !stack[-1]
        @ip = @labels[label]
      else
        stack.pop
      end
    end

    def jump_if_true label
      if stack[-1]
        @ip = @labels[label]
      else
        stack.pop
      end
    end

    def compare comparison
      left = stack[-2]
      right = stack[-1]
      res = send "compare_#{comparison}", left, right
      stack.pop 2
      stack.push res
    end

    def compare_EQ left, right
      left == right
    end

    # Build up a map of label => instruction_pointer
    def process_labels
      @instructions.each_with_index do |inst, idx|
        next unless inst[:op] == "label"
        @labels[inst[:label]] = idx
      end
    end
  end
end
