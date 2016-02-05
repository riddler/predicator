require_relative "test_helper"

class TransformTest < Minitest::Test
  attr_accessor :transform

  def setup
    @transform = Predicator::Transform.new
  end

  def test_boolean_transform
    assert_equal transform.apply(:boolean => "true"), true
    assert_equal transform.apply(:boolean => "false"), false
  end

  def test_not_transform
    tree = {:not=>{:boolean=>"true "}}
    assert_equal transform.apply(tree), Predicator::Predicates::Not.new(true)
  end

  def test_or_transform
    tree = {:or=>{:array => [{:boolean=>"true "}, {:boolean=>"false"}]}}
    assert_equal transform.apply(tree), Predicator::Predicates::Or.new([true, false])
  end

  def test_and_transform
    tree = {:and=>{:array => [{:boolean=>"true "}, {:boolean=>"false"}]}}
    assert_equal transform.apply(tree), Predicator::Predicates::And.new([true, false])
  end
end
