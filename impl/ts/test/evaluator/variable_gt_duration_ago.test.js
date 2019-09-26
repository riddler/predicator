// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates variable_gt_duration_ago with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","start_date"],["to_date"],["lit",259200],["date_ago"],["compare","GT"]],
    {});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_gt_duration_ago with_blank_date', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","start_date"],["to_date"],["lit",259200],["date_ago"],["compare","GT"]],
    {"start_date":""});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_gt_duration_ago with_future_date', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","start_date"],["to_date"],["lit",259200],["date_ago"],["compare","GT"]],
    {"start_date":"2299-01-01"});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_gt_duration_ago with_past_date', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","start_date"],["to_date"],["lit",259200],["date_ago"],["compare","GT"]],
    {"start_date":"1999-01-01"});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
