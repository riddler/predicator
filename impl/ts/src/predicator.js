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
  evaluate,
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
  evaluate,
  evaluateInstructions,

  toInstructions
}
