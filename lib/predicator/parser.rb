module Predicator
  class Parser < Parslet::Parser
    rule(:space)  { match[" "].repeat(1) }
    rule(:space?) { space.maybe }

    rule(:question) { s("?") }
    rule(:period) { s(".") }
    rule(:comma)  { s(",") }
    rule(:lparen) { s("(") }
    rule(:rparen) { s(")") }

    rule(:and_op) { s("and") }
    rule(:or_op)  { s("or") }
    rule(:not_op) { s("!") | s("not") }

    rule :boolean do
      (s("true") | s("false")).as :boolean
    end

    rule :identifier do
      (match['a-z'] >> match['\w\d'].repeat)
    end

    rule :variable do
      (identifier >> period >> identifier >> question.maybe).as(:variable) >> space?
    end

    rule :not_predicate do
      (not_op >> lparen >> predicate >> rparen).as(:not)
    end

    rule :and_predicate do
      (and_op >> lparen >>
      (predicate >> (comma >> predicate).repeat.maybe).as(:array) >>
      rparen).as(:and)
    end

    rule :or_predicate do
      (or_op >> lparen >>
      (predicate >> (comma >> predicate).repeat.maybe).as(:array) >>
      rparen).as(:or)
    end

    rule :predicate do
      boolean | not_predicate | or_predicate | and_predicate
    end

    root :predicate

  private
    # Defines a string followed by any number of spaces.
    def s str, name=nil
      if name
        str(str).as(name) >> space?
      else
        str(str) >> space?
      end
    end
  end
end
