// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates int_in_array with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["lit",1],["array",[1,2]],["compare","IN"]],
    {});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
