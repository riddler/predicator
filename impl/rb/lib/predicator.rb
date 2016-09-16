require "predicator/parser"
require "predicator/context"
require "predicator/evaluator"

module Predicator
  def self.parse string
    Predicator::Parser.new.parse string
  end
end
