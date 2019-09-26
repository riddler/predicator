// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates variable_eq_int with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","age"],["to_int"],["lit",21],["compare","EQ"]],
    {});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_int with_blank_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","age"],["to_int"],["lit",21],["compare","EQ"]],
    {"age":""});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_int with_correct_int', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","age"],["to_int"],["lit",21],["compare","EQ"]],
    {"age":21});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_int with_incorrect_int', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","age"],["to_int"],["lit",21],["compare","EQ"]],
    {"age":5});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_int with_correct_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","age"],["to_int"],["lit",21],["compare","EQ"]],
    {"age":"21"});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_int with_incorrect_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","age"],["to_int"],["lit",21],["compare","EQ"]],
    {"age":"5"});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
