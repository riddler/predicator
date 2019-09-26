// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates true with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["lit",true]],
    {});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
