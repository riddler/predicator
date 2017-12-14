require "helper"

module Predicator
  class TestLexer < Minitest::Test
    def setup
      @lexer = Lexer.new
    end

    def test_tokens
      [
        ["    ",    []],
        [".",       [[:DOT, "."]]],
        [" true ",  [[:TRUE, "true"]]],
        ["true",    [[:TRUE, "true"]]],
        ["false",   [[:FALSE, "false"]]],
        ["between", [[:BETWEEN, "between"]]],
        ["in",      [[:IN, "in"]]],
        ["not",     [[:NOT, "not"]]],
        ["123",     [[:INTEGER, "123"]]],
        ["'foo'",   [[:STRING, "foo"]]],
        ['"foo"',   [[:STRING, "foo"]]],
        ["foo",     [[:IDENTIFIER, "foo"]]],
        ["a='b'",   [
                      [:IDENTIFIER, "a"],
                      [:EQ, "="],
                      [:STRING, "b"]
                    ]],
        ["a>1",     [
                      [:IDENTIFIER, "a"],
                      [:GT, ">"],
                      [:INTEGER, "1"]
                    ]],
        ["a<1",     [
                      [:IDENTIFIER, "a"],
                      [:LT, "<"],
                      [:INTEGER, "1"]
                    ]],
        ["!true",   [
                      [:BANG, "!"],
                      [:TRUE, "true"]
                    ]],
        ["(true)",  [
                      [:LPAREN, "("],
                      [:TRUE, "true"],
                      [:RPAREN, ")"],
                    ]],
        ["[1]", [
                  [:LBRACKET, "["],
                  [:INTEGER, "1"],
                  [:RBRACKET, "]"]
                ]],
        ["[1, 2]", [
                  [:LBRACKET, "["],
                  [:INTEGER, "1"],
                  [:COMMA, ","],
                  [:INTEGER, "2"],
                  [:RBRACKET, "]"]
                ]],
        ["2018-07-10",  [[:DATE, "2018-07-10"]]],
        ["2018/07/10",  [[:DATE, "2018/07/10"]]],
      ].each do |str, expected|
        #@lexer.scan_setup str
        @lexer.parse str
        assert_tokens expected, @lexer
      end
    end

    def assert_tokens tokens, lexer
      toks = []
      while (tok = lexer.next_token)
        toks << tok
      end
      assert_equal tokens, toks
    end
  end
end
