// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { compile } = require('../../src/predicator')

test('it compiles true', () => {
  expect(compile(`true`)).toEqual([["lit",true]])
})
test('it compiles false', () => {
  expect(compile(`false`)).toEqual([["lit",false]])
})
test('it compiles group', () => {
  expect(compile(`(true)`)).toEqual([["lit",true]])
})
test('it compiles not', () => {
  expect(compile(`!true`)).toEqual([["lit",true],["not"]])
})
test('it compiles or', () => {
  expect(compile(`true or true`)).toEqual([["lit",true],["jtrue",2],["lit",true]])
})
test('it compiles and', () => {
  expect(compile(`true and true`)).toEqual([["lit",true],["jfalse",2],["lit",true]])
})
test('it compiles variable_eq_int', () => {
  expect(compile(`age = 13`)).toEqual([["load","age"],["to_int"],["lit",13],["compare","EQ"]])
})
test('it compiles variable_eq_string_single_quotes', () => {
  expect(compile(`plan = 'basic'`)).toEqual([["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]])
})
test('it compiles variable_eq_string_double_quotes', () => {
  expect(compile(`plan = "basic"`)).toEqual([["load","plan"],["to_str"],["lit","basic"],["compare","EQ"]])
})
test('it compiles variable_eq_date', () => {
  expect(compile(`date = 2019-06-20`)).toEqual([["load","date"],["to_date"],["lit","2019-06-20"],["to_date"],["compare","EQ"]])
})
test('it compiles variable_gt_duration_ago', () => {
  expect(compile(`date > 3d ago`)).toEqual([["load","date"],["to_date"],["lit",259200],["date_ago"],["compare","GT"]])
})
test('it compiles variable_gt_duration_from_now', () => {
  expect(compile(`date > 3d from now`)).toEqual([["load","date"],["to_date"],["lit",259200],["date_from_now"],["compare","GT"]])
})
