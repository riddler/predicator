require_relative "test_helper"

class TransformTest < Minitest::Test
  attr_accessor :transform

  def setup
    @transform = Predicator::Transform.new
  end

  def test_boolean_transform
    assert_equal true, transform.apply(:boolean => "true")
    assert_equal false, transform.apply(:boolean => "false")
  end

  def test_not_transform
    tree = {:not=>{:boolean=>"true "}}
    assert_equal Predicator::Predicates::Not.new(true), transform.apply(tree)
  end

  def test_or_transform
    tree = {:or=>{:array => [{:boolean=>"true "}, {:boolean=>"false"}]}}
    assert_equal Predicator::Predicates::Or.new([true, false]), transform.apply(tree)
  end

  def test_and_transform
    tree = {:and=>{:array => [{:boolean=>"true "}, {:boolean=>"false"}]}}
    assert_equal Predicator::Predicates::And.new([true, false]), transform.apply(tree)
  end
end
