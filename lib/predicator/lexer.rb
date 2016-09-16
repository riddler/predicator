require "stringio"
require "strscan"

module Predicator
  class Lexer
    SPACE       = /[ \t\r\n]/
    LPAREN      = /\(/
    RPAREN      = /\)/
    TRUE        = /true\b/
    FALSE       = /false\b/
    BANG        = /!/
    AT          = /@/
    AND         = /and\b/
    OR          = /or\b/
    EQ          = /=/
    GT          = />/
    INTEGER     = /[+-]?\d(_?\d)*\b/
    STRING      = /(["'])(?:\\?.)*?\1/
    IDENTIFIER  = /[a-z][A-Za-z0-9_]*\b/

    def initialize
      @ss = nil
    end

    def scan_setup string_or_io
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

    def add token
      @tokens.push token
    end

    def tokenize
      until @ss.eos?
        case
        when        @ss.scan(SPACE)       # ignore space
        when text = @ss.scan(LPAREN)      then add [:LPAREN, text]
        when text = @ss.scan(RPAREN)      then add [:RPAREN, text]
        when text = @ss.scan(TRUE)        then add [:TRUE, text]
        when text = @ss.scan(FALSE)       then add [:FALSE, text]
        when text = @ss.scan(BANG)        then add [:BANG, text]
        when text = @ss.scan(AT)          then add [:AT, text]
        when text = @ss.scan(AND)         then add [:AND, text]
        when text = @ss.scan(OR)          then add [:OR, text]
        when text = @ss.scan(EQ)          then add [:EQ, text]
        when text = @ss.scan(GT)          then add [:GT, text]
        when text = @ss.scan(INTEGER)     then add [:INTEGER, text]
        when text = @ss.scan(STRING)      then add [:STRING, text[1...-1]]
        when text = @ss.scan(IDENTIFIER)  then add [:IDENTIFIER, text]

        else
          raise "Unexpected characters: #{@ss.peek(5).inspect}"
        end
      end

      #@tokens.push [false, false]
    end
  end
end
