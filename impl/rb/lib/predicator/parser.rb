#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.14
# from Racc grammer file "".
#

require 'racc/parser.rb'

require "predicator/lexer.rex"
require "predicator/visitors"
require "predicator/ast"
module Predicator
  class Parser < Racc::Parser

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

##### State transition tables begin ###

racc_action_table = [
     6,     7,     9,     6,     7,     9,     8,    30,    38,     8,
     6,     7,     9,    36,    17,    18,     8,    14,    13,    15,
    14,    13,    15,    16,     6,     7,     9,    14,    13,    15,
     8,     6,     7,     9,    37,    17,    18,     8,    14,    13,
    15,    14,    13,    15,    42,    17,    18,    43,    14,    13,
    15,    21,    22,    23,    24,    25,    14,    13,    15,    14,
    13,    15,    14,    13,    15,    14,    13,    15,    17,    18,
    14,    13,    17,    18,    14,    13,    26,    27 ]

racc_action_check = [
     0,     0,     0,     8,     8,     8,     0,    20,    34,     8,
     9,     9,     9,    25,    20,    20,     9,     0,     0,     0,
     8,     8,     8,     1,    18,    18,    18,     9,     9,     9,
    18,    17,    17,    17,    26,     1,     1,    17,    22,    22,
    22,    18,    18,    18,    39,    28,    28,    39,    17,    17,
    17,    10,    10,    10,    10,    10,    21,    21,    21,    23,
    23,    23,    24,    24,    24,    38,    38,    38,    19,    19,
    36,    36,    29,    29,    43,    43,    12,    16 ]

racc_action_pointer = [
    -2,    23,   nil,   nil,   nil,   nil,   nil,   nil,     1,     8,
    37,   nil,    67,   nil,   nil,   nil,    77,    29,    22,    56,
     2,    37,    19,    40,    43,     7,    13,   nil,    33,    60,
   nil,   nil,   nil,   nil,    -4,   nil,    51,   nil,    46,    37,
   nil,   nil,   nil,    55,   nil ]

racc_action_default = [
   -25,   -25,    -1,    -2,    -3,    -4,    -5,    -6,   -25,   -25,
   -25,   -19,   -20,   -21,   -22,   -23,   -25,   -25,   -25,    -7,
   -25,   -25,   -25,   -25,   -25,   -25,   -25,    45,    -8,    -9,
   -10,   -11,   -12,   -13,   -25,   -15,   -25,   -24,   -25,   -25,
   -17,   -14,   -16,   -25,   -18 ]

racc_goto_table = [
     1,    35,    31,    32,    33,    34,    40,    39,    19,    20,
   nil,   nil,   nil,    44,   nil,   nil,   nil,    28,    29,    41 ]

racc_goto_check = [
     1,     7,     6,     6,     6,     6,     9,     8,     1,     1,
   nil,   nil,   nil,     9,   nil,   nil,   nil,     1,     1,     6 ]

racc_goto_pointer = [
   nil,     0,   nil,   nil,   nil,   nil,   -19,   -24,   -29,   -30,
   nil ]

racc_goto_default = [
   nil,   nil,     2,     3,     4,     5,    10,   nil,   nil,    11,
    12 ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 23, :_reduce_none,
  1, 23, :_reduce_none,
  1, 23, :_reduce_none,
  1, 23, :_reduce_none,
  1, 24, :_reduce_5,
  1, 24, :_reduce_6,
  2, 25, :_reduce_7,
  3, 25, :_reduce_8,
  3, 25, :_reduce_9,
  3, 26, :_reduce_10,
  3, 27, :_reduce_11,
  3, 27, :_reduce_12,
  3, 27, :_reduce_13,
  5, 27, :_reduce_14,
  3, 27, :_reduce_15,
  3, 29, :_reduce_16,
  1, 30, :_reduce_17,
  3, 30, :_reduce_18,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 31, :_reduce_21,
  1, 31, :_reduce_22,
  1, 32, :_reduce_23,
  3, 32, :_reduce_24 ]

racc_reduce_n = 25

racc_shift_n = 45

racc_token_table = {
  false => 0,
  :error => 1,
  :TRUE => 2,
  :FALSE => 3,
  :LPAREN => 4,
  :RPAREN => 5,
  :LBRACKET => 6,
  :RBRACKET => 7,
  :BANG => 8,
  :DOT => 9,
  :COMMA => 10,
  :AT => 11,
  :AND => 12,
  :OR => 13,
  :EQ => 14,
  :GT => 15,
  :LT => 16,
  :BETWEEN => 17,
  :IN => 18,
  :INTEGER => 19,
  :STRING => 20,
  :IDENTIFIER => 21 }

racc_nt_base = 22

racc_use_result_var = false

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "TRUE",
  "FALSE",
  "LPAREN",
  "RPAREN",
  "LBRACKET",
  "RBRACKET",
  "BANG",
  "DOT",
  "COMMA",
  "AT",
  "AND",
  "OR",
  "EQ",
  "GT",
  "LT",
  "BETWEEN",
  "IN",
  "INTEGER",
  "STRING",
  "IDENTIFIER",
  "$start",
  "predicate",
  "boolean_predicate",
  "logical_predicate",
  "group_predicate",
  "comparison_predicate",
  "value",
  "array",
  "array_contents",
  "literal",
  "variable" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

# reduce 3 omitted

# reduce 4 omitted

def _reduce_5(val, _values)
 AST::True.new true 
end

def _reduce_6(val, _values)
 AST::False.new false 
end

def _reduce_7(val, _values)
 AST::Not.new val.last 
end

def _reduce_8(val, _values)
 AST::And.new val.first, val.last 
end

def _reduce_9(val, _values)
 AST::Or.new val.first, val.last 
end

def _reduce_10(val, _values)
 AST::Group.new val[1] 
end

def _reduce_11(val, _values)
 AST::Equal.new val.first, val.last 
end

def _reduce_12(val, _values)
 AST::GreaterThan.new val.first, val.last 
end

def _reduce_13(val, _values)
 AST::LessThan.new val.first, val.last 
end

def _reduce_14(val, _values)
 AST::Between.new val.first, val[2], val.last 
end

def _reduce_15(val, _values)
 AST::In.new val.first, val.last
end

def _reduce_16(val, _values)
AST::Array.new val[1]
end

def _reduce_17(val, _values)
[val.first]
end

def _reduce_18(val, _values)
[val.first, val.last].flatten
end

# reduce 19 omitted

# reduce 20 omitted

def _reduce_21(val, _values)
 AST::String.new val.first 
end

def _reduce_22(val, _values)
 AST::Integer.new val.first.to_i 
end

def _reduce_23(val, _values)
 AST::Variable.new val.first 
end

def _reduce_24(val, _values)
 AST::Variable.new [val.first, val.last].flatten.join(".") 
end

def _reduce_none(val, _values)
  val[0]
end

  end   # class Parser
  end   # module Predicator
