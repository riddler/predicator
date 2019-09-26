// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')

test('it evaluates variable_eq_string with_no_context', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]],
    {});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_string with_blank_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]],
    {"plan":""});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_string with_correct_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]],
    {"plan":"basic"});
  expect(evaluator.result()).toEqual(true);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_string with_incorrect_string', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]],
    {"plan":"free"});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_string with_int', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]],
    {"plan":1});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_string with_false', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]],
    {"plan":false});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
test('it evaluates variable_eq_string with_true', () => {
  const evaluator = new PredicatorEvaluator(
    [["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]],
    {"plan":true});
  expect(evaluator.result()).toEqual(false);
  expect(evaluator.stack).toEqual([]);
})
