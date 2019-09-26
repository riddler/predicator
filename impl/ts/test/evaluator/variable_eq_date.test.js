// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates variable_eq_date with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","start_date"],["to_date"],["lit","2017-09-10"],["to_date"],["compare","EQ"]],
    {});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_date with_blank_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","start_date"],["to_date"],["lit","2017-09-10"],["to_date"],["compare","EQ"]],
    {"age":""});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_date with_correct_date_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","start_date"],["to_date"],["lit","2017-09-10"],["to_date"],["compare","EQ"]],
    {"start_date":"2017-09-10"});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_date with_incorrect_date_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","start_date"],["to_date"],["lit","2017-09-10"],["to_date"],["compare","EQ"]],
    {"start_date":"2017-09-09"});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
