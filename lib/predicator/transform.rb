module Predicator
  class Transform < Parslet::Transform
    rule(:boolean => simple(:b)) { !!(b.match /true/) }
    rule(:array => subtree(:a)) { Array(a) }

    rule(:not => subtree(:sub)) { Predicator::Predicates::Not.new sub }
    rule(:or => subtree(:sub)) { Predicator::Predicates::Or.new sub }
    rule(:and => subtree(:sub)) { Predicator::Predicates::And.new sub }
  end
end
