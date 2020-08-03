// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

// const { compile } = require('../../src/predicator')

// test('it compiles true', () => {
//   expect(compile(`true`)).toEqual([["lit",true]])
// })
// test('it compiles false', () => {
//   expect(compile(`false`)).toEqual([["lit",false]])
// })

// test('it compiles group', () => {
//   expect(compile(`(true)`)).toEqual([["lit",true]])
// })
// test('it compiles not_exclaimation', () => {
//   expect(compile(`!true`)).toEqual([["lit",true],["not"]])
// })
// test('it compiles not', () => {
//   expect(compile(`not true`)).toEqual([["lit",true],["not"]])
// })
// test('it compiles or', () => {
//   expect(compile(`true or true`)).toEqual([["lit",true],["jtrue",2],["lit",true]])
// })
// test('it compiles and', () => {
//   expect(compile(`true and true`)).toEqual([["lit",true],["jfalse",2],["lit",true]])
// })
// test('it compiles equal', () => {
//   expect(compile(`5 = 5`)).toEqual([["lit",5],["lit",5],["compare","="]])
// })
// test('it compiles not_equal', () => {
//   expect(compile(`5 != 5`)).toEqual([["lit",5],["lit",5],["compare","!="]])
// })
// test('it compiles is', () => {
//   expect(compile(`5 is 5`)).toEqual([["lit",5],["lit",5],["compare","="]])
// })
// test('it compiles is not', () => {
//   expect(compile(`5 is not 5`)).toEqual([["lit",5],["lit",5],["compare","!="]])
// })
// test('it compiles greater_than', () => {
//   expect(compile(`5 > 5`)).toEqual([["lit",5],["lit",5],["compare",">"]])
// })
// test('it compiles greater_than_or_eqal', () => {
//   expect(compile(`5 >= 5`)).toEqual([["lit",5],["lit",5],["compare",">="]])
// })
// test('it compiles less_than', () => {
//   expect(compile(`5 < 5`)).toEqual([["lit",5],["lit",5],["compare","<"]])
// })
// test('it compiles less_than_or_eqal', () => {
//   expect(compile(`5 <= 5`)).toEqual([["lit",5],["lit",5],["compare","<="]])
// })
// test('it compiles contains', () => {
//   expect(compile(`[1, 2, 3] contians 2`)).toEqual([["lit",[1,2,3]],["lit",2],["contains"]])
// })
// test('it compiles not_contains', () => {
//   expect(compile(`[1, 2, 3] not contians 2`)).toEqual([["lit",[1,2,3]],["lit",2],["not_contains"]])
// })
// test('it compiles in', () => {
//   expect(compile(`2 in [1, 2, 3]`)).toEqual([["lit",2],["lit",[1,2,3]],["in"]])
// })
// test('it compiles not_in', () => {
//   expect(compile(`2 not in [1, 2, 3]`)).toEqual([["lit",2],["lit",[1,2,3]],["not_in"]])
// })
// test('it compiles matches', () => {
//   expect(compile(`'foo' matches 'o+'`)).toEqual([["lit","foo"],["lit","o+"],["matches"]])
// })
// test('it compiles not_matches', () => {
//   expect(compile(`'foo' not matches 'o+'`)).toEqual([["lit","foo"],["lit","o+"],["not_matches"]])
// })
// test('it compiles lone_variable_adds_bool_conversion', () => {
//   expect(compile(`is_enabled`)).toEqual([["load","is_enabled"],["to_bool"]])
// })
// test('it compiles nested_identifier', () => {
//   expect(compile(`account.is_enabled`)).toEqual([["load","account.is_enabled"],["to_bool"]])
// })
// test('it compiles no_double_typecast', () => {
//   expect(compile(`account.is_enabled::bool`)).toEqual([["load","account.is_enabled"],["to_bool"]])
// })
