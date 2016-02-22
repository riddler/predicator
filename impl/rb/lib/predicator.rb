require "predicator/lexer"
require "predicator/parser"
require "predicator/version"

module Predicator
  def self.parse string
    Predicator::Parser.new.parse string
  end
end
