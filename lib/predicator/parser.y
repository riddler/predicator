class Predicator::GeneratedParser
options no_result_var
prechigh
  right tBANG
  left  tAND tOR
preclow
token tTRUE tFALSE tSTRING tFLOAT tINTEGER tDATE tIDENTIFIER tDOT tEQUAL
      tLPAREN tRPAREN tAND tOR tBANG
rule
  predicate
    : equals_predicate
    | boolean_predicate
    | logical_predicate
    | tLPAREN predicate tRPAREN
    ;
  equals_predicate
    : value tEQUAL value { Predicator::Predicates::Equals.new val[0], val[2] }
    ;
  boolean_predicate
    : tTRUE { Predicator::Predicates::True.new }
    | tFALSE { Predicator::Predicates::False.new }
    ;
  logical_predicate
    : predicate tAND predicate { Predicator::Predicates::And.new [val[0], val[2]] }
    | predicate tOR predicate  { Predicator::Predicates::Or.new [val[0], val[2]] }
    | tBANG predicate          { Predicator::Predicates::Not.new val[0] }
    ;
  value
    : scalar
    | variable
    ;
  scalar
    : string
    | literal
    ;
  string
    : tSTRING   { val[0] }
    ;
  literal
    : tFLOAT    { val[0].to_f }
    | tINTEGER  { val[0].to_i }
    | tDATE     { Date.new *val[0] }
    ;
  variable
    : tIDENTIFIER tDOT tIDENTIFIER { Predicator::Variable.new val[0], val[2] }
    ;
