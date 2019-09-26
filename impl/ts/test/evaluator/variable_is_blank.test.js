// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates variable_is_blank with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","foo"],["blank"]],
    {});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_is_blank with_blank_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","foo"],["blank"]],
    {"foo":""});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_is_blank with_int', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","foo"],["blank"]],
    {"foo":1});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_is_blank with_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","foo"],["blank"]],
    {"foo":"bar"});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
