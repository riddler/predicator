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
  end
end
