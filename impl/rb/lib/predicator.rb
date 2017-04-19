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

  def self.evaluate source
    instructions = compile source
    evaluator = Evaluator.new instructions
    evaluator.result
  end
end
