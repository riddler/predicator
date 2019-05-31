// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')


test('it evaluates with_no_context', () => {
  const context = {};
  const instructions = [["load","bool_var"],["to_bool"]];
  const evaluator = new PredicatorEvaluator(instructions, context);
  const result = evaluator.result();

  expect(result).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})

test('it evaluates with_false', () => {
  const context = {"bool_var":false};
  const instructions = [["load","bool_var"],["to_bool"]];
  const evaluator = new PredicatorEvaluator(instructions, context);
  const result = evaluator.result();

  expect(result).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})

test('it evaluates with_true', () => {
  const context = {"bool_var":true};
  const instructions = [["load","bool_var"],["to_bool"]];
  const evaluator = new PredicatorEvaluator(instructions, context);
  const result = evaluator.result();

  expect(result).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})