// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')


test('it evaluates with_no_context', () => {
  const context = {};
  const instructions = [["lit",0],["array",[1,2]],["compare","IN"]];
  const evaluator = new PredicatorEvaluator(instructions, context);
  const result = evaluator.result();

  expect(result).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})