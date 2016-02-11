module Predicator
  class Transform < Parslet::Transform
    rule(:array => subtree(:a)) { Array(a) }

    rule(:boolean => simple(:b)) do
      if b.match /true/
        Predicates::True.new
      else
        Predicates::False.new
      end
    end

    rule(:not => subtree(:sub)) { Predicates::Not.new sub }
    rule(:or => subtree(:sub)) { Predicates::Or.new sub }
    rule(:and => subtree(:sub)) { Predicates::And.new sub }
  end
end
