// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates variable_is_present with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","foo"],["present"]],
    {});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_is_present with_blank_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","foo"],["present"]],
    {"foo":""});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_is_present with_int', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","foo"],["present"]],
    {"foo":1});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_is_present with_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","foo"],["present"]],
    {"foo":"bar"});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
