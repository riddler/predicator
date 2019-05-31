// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { toInstructions } = require('../../src/predicator')


test('it compiles true', () => {
  expect(toInstructions('true')).toEqual([["lit",true]])
})

test('it compiles false', () => {
  expect(toInstructions('false')).toEqual([["lit",false]])
})

test('it compiles group', () => {
  expect(toInstructions('(true)')).toEqual([["lit",true]])
})

test('it compiles not', () => {
  expect(toInstructions('!true')).toEqual([["lit",true],["not"]])
})

test('it compiles or', () => {
  expect(toInstructions('true or true')).toEqual([["lit",true],["jtrue",2],["lit",true]])
})

test('it compiles and', () => {
  expect(toInstructions('true and true')).toEqual([["lit",true],["jfalse",2],["lit",true]])
})

test('it compiles var_eq_int', () => {
  expect(toInstructions('score = 100')).toEqual([["load","score"],["lit",100],["compare","EQ"]])
})