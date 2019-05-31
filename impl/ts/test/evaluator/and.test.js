// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')


test('it evaluates with_no_context', () => {
  const context = {};
  const instructions = [["lit",true],["jfalse",2],["lit",true]];
  const evaluator = new PredicatorEvaluator(instructions, context);
  const result = evaluator.result();

  expect(result).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})