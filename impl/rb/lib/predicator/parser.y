class Predicator::GeneratedParser
options no_result_var
token tTRUE tFALSE tINTEGER tIDENTIFIER tDOT tEQUAL
rule
  predicate
    : equals_predicate
    ;
  equals_predicate
    : value tEQUAL value { Predicator::Predicates::Equals.new val[0], val[2] }
    ;
  value
    : scalar
    | variable
    ;
  scalar
    : literal
    ;
  literal
    : tINTEGER   { val[0].to_i }
    ;
  variable
    : tIDENTIFIER tDOT tIDENTIFIER { Predicator::Variable.new val[0], val[2] }
    ;
