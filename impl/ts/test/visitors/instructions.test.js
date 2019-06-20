// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { compile } = require('../../src/predicator')


test('it compiles true', () => {
  expect(compile('true')).toEqual([["lit",true]])
})

test('it compiles false', () => {
  expect(compile('false')).toEqual([["lit",false]])
})

test('it compiles group', () => {
  expect(compile('(true)')).toEqual([["lit",true]])
})

test('it compiles not', () => {
  expect(compile('!true')).toEqual([["lit",true],["not"]])
})

test('it compiles or', () => {
  expect(compile('true or true')).toEqual([["lit",true],["jtrue",2],["lit",true]])
})

test('it compiles and', () => {
  expect(compile('true and true')).toEqual([["lit",true],["jfalse",2],["lit",true]])
})