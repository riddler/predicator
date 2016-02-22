class Predicator::GeneratedParser
options no_result_var
token tTRUE tFALSE tSTRING tFLOAT tINTEGER tDATE tIDENTIFIER tDOT tEQUAL tLPAREN tRPAREN
rule
  predicate
    : equals_predicate
    | boolean_predicate
    | tLPAREN predicate tRPAREN
    ;
  equals_predicate
    : value tEQUAL value { Predicator::Predicates::Equals.new val[0], val[2] }
    ;
  boolean_predicate
    : tTRUE { Predicator::Predicates::True.new }
    | tFALSE { Predicator::Predicates::False.new }
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
