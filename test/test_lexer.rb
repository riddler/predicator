require "helper"

module Predicator
  class TestLexer < Minitest::Test
    def setup
      @lexer = Lexer.new
    end

    def test_tokens
      [
        ["    ",    []],
        [" true ",  [[:TRUE, "true"]]],
        ["true",    [[:TRUE, "true"]]],
        ["false",   [[:FALSE, "false"]]],
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
        ["!true",   [
                      [:BANG, "!"],
                      [:TRUE, "true"]
                    ]],
        ["(true)",  [
                      [:LPAREN, "("],
                      [:TRUE, "true"],
                      [:RPAREN, ")"],
                    ]],
        ["@foo",    [
                      [:AT, "@"],
                      [:IDENTIFIER, "foo"]
                    ]],
      ].each do |str, expected|
        @lexer.scan_setup str
        assert_tokens expected, @lexer
      end
    end

    def assert_tokens tokens, lexer
      toks = []
      while tok = lexer.next_token
        toks << tok
      end
      assert_equal tokens, toks
    end
  end
end
