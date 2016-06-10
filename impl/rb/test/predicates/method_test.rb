require_relative "../test_helper"

class MethodTest < Minitest::Test
  def test_blank_variable_is_blank
    context = Predicator::Context.new a: {b:""}
    variable = Predicator::Variable.new "a", "b"
    pred = Predicator::Predicates::Method.new variable, "blank?"

    assert pred.satisfied?(context)
  end

  def test_present_variable_is_not_blank
    context = Predicator::Context.new a: {b:"foo"}
    variable = Predicator::Variable.new "a", "b"
    pred = Predicator::Predicates::Method.new variable, "blank?"

    refute pred.satisfied?(context)
  end

  def test_present_variable_is_present
    context = Predicator::Context.new a: {b:"foo"}
    variable = Predicator::Variable.new "a", "b"
    pred = Predicator::Predicates::Method.new variable, "present?"

    assert pred.satisfied?(context)
  end

  def test_blank_variable_is_not_present
    context = Predicator::Context.new a: {b:""}
    variable = Predicator::Variable.new "a", "b"
    pred = Predicator::Predicates::Method.new variable, "present?"

    refute pred.satisfied?(context)
  end
end
