class Predicator::Lexer
options
  lineno
  column
macro
  SPACE       /[ \t\r\n]/
  LPAREN      /\(/
  RPAREN      /\)/
  TRUE        /true\b/
  FALSE       /false\b/
  BANG        /!/
  DOT         /\./
  AND         /and\b/
  OR          /or\b/
  EQ          /=/
  GT          />/
  LT          /</
  INTEGER     /[+-]?\d(_?\d)*\b/
  STRING      /(["'])(?:\\?.)*?\1/
  IDENTIFIER  /[a-z][A-Za-z0-9_]*\b/
rule
  /#{SPACE}/       # ignore space
  /#{LPAREN}/      { [:LPAREN, text] }
  /#{RPAREN}/      { [:RPAREN, text] }
  /#{TRUE}/        { [:TRUE, text] }
  /#{FALSE}/       { [:FALSE, text] }
  /#{BANG}/        { [:BANG, text] }
  /#{DOT}/         { [:DOT, text] }
  /#{AND}/         { [:AND, text] }
  /#{OR}/          { [:OR, text] }
  /#{EQ}/          { [:EQ, text] }
  /#{GT}/          { [:GT, text] }
  /#{LT}/          { [:LT, text] }
  /#{INTEGER}/     { [:INTEGER, text] }
  /#{STRING}/      { [:STRING, text[1...-1]] }
  /#{IDENTIFIER}/  { [:IDENTIFIER, text] }
inner
  def do_parse; end
end
