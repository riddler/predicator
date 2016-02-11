require_relative "test_helper"

module Predicator
  class TransformTest < Minitest::Test
    attr_accessor :transform

    def setup
      @transform = Predicator::Transform.new
    end

    def test_integer_transform
      assert_equal 1, transform.apply(:integer => "1")
    end

    def test_boolean_transform
      assert_equal Predicates::True.new, transform.apply(:boolean => "true")
      assert_equal Predicates::False.new, transform.apply(:boolean => "false")
    end

    def test_not_transform
      tree = {:not=>{:boolean=>"true "}}
      assert_equal Predicates::Not.new(Predicates::True.new), transform.apply(tree)
    end

    def test_or_transform
      tree = {:or=>{:array => [{:boolean=>"true "}, {:boolean=>"false"}]}}
      assert_equal Predicates::Or.new([Predicates::True.new, Predicates::False.new]), transform.apply(tree)
    end

    def test_and_transform
      tree = {:and=>{:array => [{:boolean=>"true "}, {:boolean=>"false"}]}}
      assert_equal Predicates::And.new([Predicates::True.new, Predicates::False.new]), transform.apply(tree)
    end
  end
end
