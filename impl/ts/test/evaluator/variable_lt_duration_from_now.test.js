// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates variable_lt_duration_from_now with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan_end_date"],["to_date"],["lit",259200],["date_from_now"],["compare","LT"]],
    {});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_lt_duration_from_now with_blank_date', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan_end_date"],["to_date"],["lit",259200],["date_from_now"],["compare","LT"]],
    {"plan_end_date":""});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_lt_duration_from_now with_future_date', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan_end_date"],["to_date"],["lit",259200],["date_from_now"],["compare","LT"]],
    {"plan_end_date":"2299-01-01"});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_lt_duration_from_now with_past_date', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan_end_date"],["to_date"],["lit",259200],["date_from_now"],["compare","LT"]],
    {"plan_end_date":"1999-01-01"});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
