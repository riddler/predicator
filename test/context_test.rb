require_relative "test_helper"

class ContextTest < Minitest::Test
  attr_accessor :context

  def setup
    @context = Predicator::Context.new
  end

  def test_integer
    assert_equal 1, context.value_for(1)
  end

  def test_open_struct
    context.bind :favorite, OpenStruct.new(number: 42)
    assert_equal 42, context.value_for(Predicator::Variable.new("favorite.number"))
  end

  def test_hash
    context.bind :is_this, { :valid? => true }
    assert_equal true, context.value_for(Predicator::Variable.new("is_this.valid?"))
  end
end
