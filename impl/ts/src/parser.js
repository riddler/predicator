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
      $.SUBRULE($.operand)
      $.MANY(() => {
        $.CONSUME(t.And)
        $.SUBRULE2($.predicate)
      })
    })

    // An Operand is the basic value of an expression - it may be a literal or a variable
    $.RULE('operand', () => {
      $.OR([
        { ALT: () => $.SUBRULE($.paren) },
        { ALT: () => $.SUBRULE($.not) },
        // { ALT: () => $.SUBRULE($.relationalExpression) },
        // { ALT: () => $.SUBRULE($.betweenExpression) },
        { ALT: () => $.SUBRULE($.variable) },
        { ALT: () => $.CONSUME(t.IBoolean) }
      ])
    })

    $.RULE('variable', () => {
      $.CONSUME(t.Variable)
      $.OPTION(() => {
        $.CONSUME(t.ColonColon)
        $.CONSUME(t.IType)
      });
    })

    $.RULE('paren', () => {
      $.CONSUME(t.LParen)
      $.SUBRULE($.predicate)
      $.CONSUME(t.RParen)
    })

    $.RULE('not', () => {
      $.CONSUME(t.Exclamation)
      $.SUBRULE($.predicate)
    })

    // $.RULE('relationalExpression', () => {
    //   $.CONSUME(t.Variable)
    //   $.CONSUME(t.IRelationalOperator)
    //   $.OR([
    //     { ALT: () => $.CONSUME(t.IDate) },
    //     { ALT: () => $.CONSUME(t.IInteger) },
    //     { ALT: () => $.CONSUME(t.IString) }
    //   ])
    // })

    // $.RULE('betweenExpression', () => {
    //   $.OR([
    //     { ALT: () => $.SUBRULE($.betweenIntExpression) }
    //   ])
    // })

    // $.RULE('betweenIntExpression', () => {
    //   $.CONSUME(t.Variable)
    //   $.CONSUME(t.Between)
    //   $.CONSUME(t.IInteger)
    //   $.CONSUME(t.And)
    //   $.CONSUME1(t.IInteger)
    // })

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
