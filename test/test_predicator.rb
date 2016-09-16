require "helper"

module Predicator

  class TestPredicator < Minitest::Test
    def test_parse
      ast = Predicator.parse "true"
      assert_equal :TRUE, ast.type
    end

    def test_compile
      instructions = Predicator.compile "true"
      assert_equal [{op: "lit", lit: true}], instructions
    end

    def test_create
      Predicator.create name: "good_credit", source: "true"

      found = Predicator.find "good_credit"
      assert_respond_to found, :instructions
    end
  end
end
