class Predicator::GeneratedParser
options no_result_var
prechigh
  right tBANG
  left  tAND tOR
preclow
token tTRUE tFALSE tSTRING tFLOAT tINTEGER tDATE tIDENTIFIER tAND tOR tBETWEEN
      tDOT tLPAREN tRPAREN tBANG tEQ tNEQ tLEQ tGEQ tLT tGT tBLANK tPRESENT
rule
  predicate
    : boolean_predicate
    | logical_predicate
    | relation_predicate
    | method_predicate
    | tLPAREN predicate tRPAREN { val[1] }
    | value tBETWEEN value tAND value { Predicator::Predicates::Between.new val[0], val[2], val[4] }
    ;
  boolean_predicate
    : tTRUE                     { Predicator::Predicates::True.new }
    | tFALSE                    { Predicator::Predicates::False.new }
    ;
  logical_predicate
    : predicate tAND predicate  { Predicator::Predicates::And.new [val[0], val[2]] }
    | predicate tOR predicate   { Predicator::Predicates::Or.new [val[0], val[2]] }
    | tBANG predicate           { Predicator::Predicates::Not.new val[0] }
    ;
  relation_predicate
    : value tEQ value           { Predicator::Predicates::Equal.new val[0], val[2] }
    | value tGT value           { Predicator::Predicates::GreaterThan.new val[0], val[2] }
    | value tLT value           { Predicator::Predicates::LessThan.new val[0], val[2] }
    | value tGEQ value          { Predicator::Predicates::GreaterThanOrEqual.new val[0], val[2] }
    | value tLEQ value          { Predicator::Predicates::LessThanOrEqual.new val[0], val[2] }
    | value tNEQ value          { Predicator::Predicates::NotEqual.new val[0], val[2] }
    ;
  method_predicate
    : value tDOT tBLANK         { Predicator::Predicates::Method.new val[0], val[2] }
    | value tDOT tPRESENT       { Predicator::Predicates::Method.new val[0], val[2] }
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
