// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates int_eq_int with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["lit",1],["lit",1],["compare","EQ"]],
    {});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
