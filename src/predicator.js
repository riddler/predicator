// ----------------- Lexer -----------------
const { compile } = require('./visitors/instructions')
const { tokenize } = require('./lexer')
const {
  PredicatorParser,
  parse,
  BasePredicatorCstVisitor,
  BasePredicatorCstVisitorWithDefaults
} = require('./parser')
const {
  PredicatorEvaluator,
  evaluate,
  evaluateInstructions
} = require('./evaluator')

module.exports = {
  BasePredicatorCstVisitor,
  BasePredicatorCstVisitorWithDefaults,
  PredicatorParser,
  PredicatorEvaluator,

  tokenize,
  parse,
  compile,
  evaluate,
  evaluateInstructions
}
