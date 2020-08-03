require "predicator/context"
require "predicator/evaluator"
require "predicator/parser"

module Predicator
  def self.parse source
    Predicator::Parser.new.parse source
  end

  def self.compile source
    ast = parse source
    ast.to_instructions
  end

  def self.evaluate source, context={}
    instructions = compile source
    evaluate_instructions instructions, context
  end

  def self.evaluate_instructions instructions, context={}
    evaluator = Evaluator.new instructions, context
    evaluator.result
  end
end
