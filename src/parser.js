const { tokensDictionary: t, tokenize } = require('./lexer')
const { Parser } = require('chevrotain')

class PredicatorParser extends Parser {
  constructor () {
    super(t, {
      recoveryEnabled: true
    })

    const $ = this

    $.RULE('predicate', () => {
      $.SUBRULE($.or)
    })

    $.RULE('or', () => {
      $.SUBRULE($.and)
      $.MANY(() => {
        $.CONSUME(t.Or)
        $.SUBRULE2($.predicate)
      })
    })

    $.RULE('and', () => {
      $.SUBRULE($.atomic)
      $.MANY(() => {
        $.CONSUME(t.And)
        $.SUBRULE2($.predicate)
      })
    })

    $.RULE('atomic', () => {
      $.OR([
        { ALT: () => $.SUBRULE($.paren) },
        { ALT: () => $.SUBRULE($.not) },
        { ALT: () => $.SUBRULE($.relationalExpression) },
        { ALT: () => $.CONSUME(t.Variable) },
        { ALT: () => $.CONSUME(t.IBoolean) }
      ])
    })

    $.RULE('paren', () => {
      $.CONSUME(t.LParen)
      $.SUBRULE($.predicate)
      $.CONSUME(t.RParen)
    })

    $.RULE('not', () => {
      $.CONSUME(t.Bang)
      $.SUBRULE($.predicate)
    })

    $.RULE('relationalExpression', () => {
      $.CONSUME(t.Variable)
      $.CONSUME(t.IRelationalOperator)
      $.CONSUME(t.DecimalInt)
    })

    this.performSelfAnalysis()
  }
}

const parserInstance = new PredicatorParser()
const BasePredicatorCstVisitor = parserInstance.getBaseCstVisitorConstructor()
const BasePredicatorCstVisitorWithDefaults = parserInstance.getBaseCstVisitorConstructorWithDefaults()

function parse (inputText, entryPoint = 'predicate') {
  const lexResult = tokenize(inputText)
  parserInstance.input = lexResult.tokens

  const cst = parserInstance[entryPoint]()

  return cst
}

module.exports = {
  PredicatorParser,
  parserInstance,
  parse,
  BasePredicatorCstVisitor,
  BasePredicatorCstVisitorWithDefaults
}
