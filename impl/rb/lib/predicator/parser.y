class Predicator::Parser

options no_result_var

token TRUE FALSE LPAREN RPAREN LBRACKET RBRACKET
      BANG NOT DOT COMMA AT AND OR
      EQ GT LT BETWEEN IN PRESENT BLANK
      INTEGER STRING IDENTIFIER
      DATE DURATION AGO FROMNOW
      ENDSWITH

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
    | variable PRESENT          { AST::Present.new val.first }
    | variable BLANK            { AST::Blank.new val.first }
    ;
  group_predicate
    : LPAREN predicate RPAREN   { AST::Group.new val[1] }
    ;
  comparison_predicate
    : integer_comparison_predicate
    | string_comparison_predicate
    | date_comparison_predicate
    ;
  integer_comparison_predicate
    : variable EQ integer                      { AST::IntegerEqual.new val.first, val.last }
    | variable GT integer                      { AST::IntegerGreaterThan.new val.first, val.last }
    | variable LT integer                      { AST::IntegerLessThan.new val.first, val.last }
    | variable BETWEEN integer AND integer     { AST::IntegerBetween.new val.first, val[2], val.last }
    | variable IN integer_array                { AST::IntegerIn.new val.first, val.last }
    | variable NOT IN integer_array            { AST::IntegerNotIn.new val.first, val.last }
    ;
  string_comparison_predicate
    : variable EQ string                       { AST::StringEqual.new val.first, val.last }
    | variable GT string                       { AST::StringGreaterThan.new val.first, val.last }
    | variable LT string                       { AST::StringLessThan.new val.first, val.last }
    | variable IN string_array                 { AST::StringIn.new val.first, val.last }
    | variable NOT IN string_array             { AST::StringNotIn.new val.first, val.last }
    | variable ENDSWITH string                 { AST::StringEndsWith.new val.first, val.last }
    ;
  date_comparison_predicate
    : variable EQ date                         { AST::DateEqual.new val.first, val.last }
    | variable GT date                         { AST::DateGreaterThan.new val.first, val.last }
    | variable LT date                         { AST::DateLessThan.new val.first, val.last }
    | variable BETWEEN date AND date           { AST::DateBetween.new val.first, val[2], val.last }
    ;
  integer_array
    : LBRACKET integer_array_contents RBRACKET { AST::IntegerArray.new val[1] }
    ;
  integer_array_contents
    : integer
    | integer_array_contents COMMA integer     { [val.first, val.last].flatten }
    ;
  string_array
    : LBRACKET string_array_contents RBRACKET  { AST::StringArray.new val[1] }
    ;
  string_array_contents
    : string
    | string_array_contents COMMA string       { [val.first, val.last].flatten }
    ;
  integer
    : INTEGER                   { AST::Integer.new val.first.to_i }
    ;
  string
    : STRING                    { AST::String.new val.first }
    ;
  date
    : DATE                      { AST::Date.new val.first }
    | duration AGO              { AST::DateAgo.new val.first }
    | duration FROMNOW          { AST::DateFromNow.new val.first }
    ;
  duration
    : DURATION                  { AST::Duration.new val.first }
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
