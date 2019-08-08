// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { compile } = require('../../src/predicator')


test('it compiles var_eq_int', () => {
  expect(compile('age = 13')).toEqual([["load","age"],["to_int"],["lit",13],["compare","EQ"]])
})

test('it compiles var_gt_int', () => {
  expect(compile('age > 13')).toEqual([["load","age"],["to_int"],["lit",13],["compare","GT"]])
})

test('it compiles var_gte_int', () => {
  expect(compile('age >= 13')).toEqual([["load","age"],["to_int"],["lit",13],["compare","GTE"]])
})

test('it compiles var_lt_int', () => {
  expect(compile('age < 13')).toEqual([["load","age"],["to_int"],["lit",13],["compare","LT"]])
})

test('it compiles var_lte_int', () => {
  expect(compile('age <= 13')).toEqual([["load","age"],["to_int"],["lit",13],["compare","LTE"]])
})

test('it compiles var_between_int', () => {
  expect(compile('age between 13 and 15')).toEqual([["load","age"],["to_int"],["lit",13],["lit",15],["compare","BETWEEN"]])
})