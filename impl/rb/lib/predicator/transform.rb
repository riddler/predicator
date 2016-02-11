module Predicator
  class Transform < Parslet::Transform
    rule(:integer => simple(:i)) { Integer(i) }
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
    rule(:equals => {:left => subtree(:left), :right => subtree(:right)}) do
      Predicates::Equals.new left, right
    end
  end
end
