// ----------------- Lexer -----------------
const { tokenize } = require('./lexer')
const {
  PredicatorParser,
  parserInstance,
  parse,
  BasePredicatorCstVisitor,
  BasePredicatorCstVisitorWithDefaults
} = require('./parser')
const {
  PredicatorEvaluator,
  evaluateInstructions
} = require('./evaluator')

const { toInstructions } = require('./visitors/instructions')

module.exports = {
  tokenize,

  PredicatorParser,
  parserInstance,
  parse,
  BasePredicatorCstVisitor,
  BasePredicatorCstVisitorWithDefaults,

  PredicatorEvaluator,
  evaluateInstructions,

  toInstructions
}
