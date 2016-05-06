require "date"

require "predicator/context"
require "predicator/errors"
require "predicator/lexer"
require "predicator/nodes"
require "predicator/parser"
require "predicator/predicates"
require "predicator/variable"
require "predicator/version"

module Predicator
  def self.parse string
    Predicator::Parser.new.parse string
  end
end
