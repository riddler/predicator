require_relative "test_helper"

class ContextTest < Minitest::Test
  attr_accessor :context

  def setup
    @context = Predicator::Context.new
  end

  def test_open_struct
    context.bind :favorite, OpenStruct.new(number: 42)
    assert_equal 42, context.value_for("favorite.number")
  end

  def test_hash
    context.bind :is_this, { :valid? => true }
    assert_equal true, context.value_for("is_this.valid?")
  end
end
