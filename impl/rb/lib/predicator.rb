require "predicator/context"
require "predicator/evaluator"
require "predicator/parser"

module Predicator
  def self.parse source
    Predicator::Parser.new.parse source
  end

  def self.compile source
    ast = Predicator.parse source
    ast.to_instructions
  end
end
