require_relative "../test_helper"

class BaseNodeTest < Minitest::Test
  def class_for value
    Predicator::Nodes::BaseNode.class_for value
  end

  def test_class_for
    assert_equal Predicator::Nodes::NilClassNode, class_for(nil)
    assert_equal Predicator::Nodes::DateNode, class_for(Date.new)
    assert_equal Predicator::Nodes::FixnumNode, class_for(1)
    assert_equal Predicator::Nodes::FloatNode, class_for(1.1)
    assert_equal Predicator::Nodes::StringNode, class_for("foo")

    assert_raises Predicator::UnknownNodeTypeError do
      class_for Object.new
    end
  end
end
