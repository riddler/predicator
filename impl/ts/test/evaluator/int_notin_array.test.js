// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates int_notin_array with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["lit",0],["array",[1,2]],["compare","IN"]],
    {});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
