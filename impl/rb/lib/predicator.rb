require "predicator/parser"

require "predicator/variable"
require "predicator/context"
require "predicator/predicates"

require "predicator/evaluator"

module Predicator
  def self.parse string
    Predicator::Parser.new.parse string
  end
end
