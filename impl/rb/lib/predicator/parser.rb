require "date"

require "predicator/generated_parser"
require "predicator/lexer"
require "predicator/variable"

require "predicator/predicates/relation"
require "predicator/predicates/equal"
require "predicator/predicates/not_equal"
require "predicator/predicates/greater_than"
require "predicator/predicates/less_than"
require "predicator/predicates/greater_than_or_equal"
require "predicator/predicates/less_than_or_equal"
require "predicator/predicates/between"
require "predicator/predicates/true"
require "predicator/predicates/false"
require "predicator/predicates/and"
require "predicator/predicates/or"
require "predicator/predicates/not"

module Predicator
  class ParseError < StandardError; end

  class Parser < GeneratedParser
    def next_token
      @lexer.next_token
    end

    def parse string
      @lexer = Lexer.new string
      do_parse
    end

    def on_error type, val, values
      super
    rescue Racc::ParseError => e
      trace = values.each_with_index.map{|l, i| "#{' ' * i}#{l}"}
      raise ParseError, "\nparse error on value #{val.inspect}\n#{trace.join("\n")}"
    end
  end
end
