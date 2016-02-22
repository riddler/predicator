require "stringio"
require "strscan"

module Predicator
  class Lexer
    SPACE   = /[ \t\r\n]/
    DOT     = /\./
    LPAREN  = /\(/
    RPAREN  = /\)/
    NEQ     = /!=/
    GEQ     = />=/
    LEQ     = /<=/
    GT      = />/
    LT      = /</
    EQ      = /=/
    BANG    = /!/
    DATE    = /(\d{4})-(\d{2})-(\d{2})/i
    FLOAT   = /[+-]?(?:[0-9_]+\.[0-9_]*|\.[0-9_]+|\d+(?=[eE]))(?:[eE][+-]?[0-9_]+)?\b/
    INTEGER = /[+-]?\d(_?\d)*\b/
    TRUE    = /true\b/
    FALSE   = /false\b/
    AND     = /and/i
    OR      = /or/i
    STRING  = /(["])(?:\\?.)*?\1/
    IDENTIFIER = /[a-z][A-Za-z0-9_]*/

    def initialize string_or_io
      io = string_or_io.is_a?(String) ?
        StringIO.new(string_or_io) :
        string_or_io

      @ss = StringScanner.new io.read
      @tokens = []
      tokenize
    end

    def next_token
      @tokens.shift
    end

    def tokenize
      until @ss.eos?
        case
        when @ss.scan(SPACE)
          # ignore space

        when text = @ss.scan(DOT)
          @tokens.push [:tDOT, text]

        when text = @ss.scan(LPAREN)
          @tokens.push [:tLPAREN, text]

        when text = @ss.scan(RPAREN)
          @tokens.push [:tRPAREN, text]

        when text = @ss.scan(NEQ)
          @tokens.push [:tNEQ, text]

        when text = @ss.scan(GEQ)
          @tokens.push [:tGEQ, text]

        when text = @ss.scan(LEQ)
          @tokens.push [:tLEQ, text]

        when text = @ss.scan(GT)
          @tokens.push [:tGT, text]

        when text = @ss.scan(LT)
          @tokens.push [:tLT, text]

        when text = @ss.scan(EQ)
          @tokens.push [:tEQ, text]

        when text = @ss.scan(BANG)
          @tokens.push [:tBANG, text]

        when text = @ss.scan(DATE)
          args = [ @ss[1], @ss[2], @ss[3] ].map(&:to_i)
          @tokens.push [:tDATE, args]

        when text = @ss.scan(FLOAT)
          @tokens.push [:tFLOAT, text]

        when text = @ss.scan(INTEGER)
          @tokens.push [:tINTEGER, text]

        when text = @ss.scan(TRUE)
          @tokens.push [:tTRUE, text]

        when text = @ss.scan(FALSE)
          @tokens.push [:tFALSE, text]

        when text = @ss.scan(AND)
          @tokens.push [:tAND, text]

        when text = @ss.scan(OR)
          @tokens.push [:tOR, text]

        when text = @ss.scan(STRING)
          @tokens.push [:tSTRING, text[1..-2]]

        when text = @ss.scan(IDENTIFIER)
          @tokens.push [:tIDENTIFIER, text]

        else
          raise "Unexpected characters: #{@ss.peek(5).inspect}"
        end
      end

      @tokens.push [false, false]
    end
  end
end
