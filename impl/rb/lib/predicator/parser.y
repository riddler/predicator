class Predicator::Parser

options no_result_var

token TRUE FALSE LPAREN RPAREN LBRACKET RBRACKET
      BANG NOT DOT COMMA AT AND OR
      EQ GT LT BETWEEN IN
      INTEGER STRING IDENTIFIER

rule
  predicate
    : boolean_predicate
    | logical_predicate
    | group_predicate
    | comparison_predicate
    ;
  boolean_predicate
    : TRUE                      { AST::True.new true }
    | FALSE                     { AST::False.new false }
    | variable                  { AST::BooleanVariable.new val.first }
    ;
  logical_predicate
    : BANG predicate            { AST::Not.new val.last }
    | predicate AND predicate   { AST::And.new val.first, val.last }
    | predicate OR predicate    { AST::Or.new val.first, val.last }
    ;
  group_predicate
    : LPAREN predicate RPAREN   { AST::Group.new val[1] }
    ;
  comparison_predicate
    : value EQ value                { AST::Equal.new val.first, val.last }
    | value GT value                { AST::GreaterThan.new val.first, val.last }
    | value LT value                { AST::LessThan.new val.first, val.last }
    | value BETWEEN value AND value { AST::Between.new val.first, val[2], val.last }
    | value IN array                { AST::In.new val.first, val.last }
    | value NOT IN array            { AST::NotIn.new val.first, val.last }
    ;
  array
    : LBRACKET array_contents RBRACKET { AST::Array.new val[1] }
    ;
  array_contents
    : literal
    | array_contents COMMA literal  { [val.first, val.last].flatten }
    ;
  value
    : literal
    | variable
    ;
  literal
    : STRING                    { AST::String.new val.first }
    | INTEGER                   { AST::Integer.new val.first.to_i }
    ;
  variable
    : IDENTIFIER                { AST::Variable.new val.first }
    | variable DOT IDENTIFIER   { AST::Variable.new [val.first, val.last].flatten.join(".") }
    ;
end

---- inner
    def initialize
      @lexer = Lexer.new
    end

    def parse string
      @lexer.parse string
      do_parse
    end

    def next_token
      @lexer.next_token
    end

    def on_error type, val, values
      super
    rescue Racc::ParseError
      trace = values.each_with_index.map{|l, i| "#{' ' * i}#{l}"}
      raise ParseError, "\nparse error on value #{val.inspect}\n#{trace.join("\n")}"
    end

---- header
require "predicator/lexer.rex"
require "predicator/visitors"
require "predicator/ast"
