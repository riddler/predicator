// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates load_boolean with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","bool_var"],["to_bool"]],
    {});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates load_boolean with_false', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","bool_var"],["to_bool"]],
    {"bool_var":false});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates load_boolean with_true', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","bool_var"],["to_bool"]],
    {"bool_var":true});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
