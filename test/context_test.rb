require_relative "test_helper"

class ContextTest < Minitest::Test
  attr_accessor :context

  def setup
    @context = Predicator::Context.new
  end

  def test_value_for_literal
    assert_equal 1, context.value_for(1)
  end

  def test_value_for_undefined_variable
    variable = Predicator::Variable.new "a", "b"

    assert_raises ArgumentError do
      context.value_for variable
    end
  end

  def test_value_for_variable
    variable = Predicator::Variable.new "a", "b"
    context.bind :a, {b:1}

    assert_equal 1, context.value_for(variable)
  end

  def test_eval
    string = "a.b is {{ a.b }}"
    context.bind :a, {b:1}

    assert_equal "a.b is 1", context.eval(string)
  end
end
