module Predicator
  class Transform < Parslet::Transform
    rule(:integer => simple(:int)) { Integer(int) }
    rule(:array => subtree(:arr)) { Array(arr) }

    rule(:boolean => simple(:bool)) do
      if bool.match /true/
        Predicates::True.new
      else
        Predicates::False.new
      end
    end

    rule(:variable => simple(:var)) { Variable.new var.to_s }

    rule(:not => subtree(:sub)) { Predicates::Not.new sub }
    rule(:or => subtree(:sub)) { Predicates::Or.new sub }
    rule(:and => subtree(:sub)) { Predicates::And.new sub }
    rule(:equals => {:left => subtree(:left), :right => subtree(:right)}) do
      Predicates::Equals.new left, right
    end
  end
end
