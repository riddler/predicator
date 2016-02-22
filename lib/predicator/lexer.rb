require "stringio"
require "strscan"

module Predicator
  class Lexer
    SPACE   = /[ \t\r\n]/
    DOT     = /\./
    EQUAL   = /=/
    INTEGER = /[+-]?\d(_?\d)*\b/
    TRUE    = /true\b/
    FALSE   = /false\b/
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

        when text = @ss.scan(EQUAL)
          @tokens.push [:tEQUAL, text]

        when text = @ss.scan(INTEGER)
          @tokens.push [:tINTEGER, text]

        when text = @ss.scan(TRUE)
          @tokens.push [:tTRUE, text]

        when text = @ss.scan(FALSE)
          @tokens.push [:tFALSE, text]

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
