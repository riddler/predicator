require "helper"

module Predicator
  class TestContext < Minitest::Test
    def setup
      @context = Context.new
    end

    def test_binding_initial_params
      ctx = Context.new age: 21
      assert_equal 21, ctx.binding_for("age")
    end

    def test_value_of_literals
      [1, "foo"].each do |lit|
        assert_equal lit, @context.value_of(lit)
      end
    end

    def test_value_of_undefined_variable
      var = Variable.new "age"
      assert_raises UndefinedVariableError do
        @context.value_of var
      end
    end

    def test_value_of_variable
      var = Variable.new "age"
      @context.bind "age", 21

      assert_equal 21, @context.value_of(var)
    end
  end
end
