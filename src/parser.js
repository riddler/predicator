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
        { ALT: () => $.SUBRULE($.comparison) },
        { ALT: () => $.CONSUME(t.Variable) },
        { ALT: () => $.CONSUME(t.True) },
        { ALT: () => $.CONSUME(t.False) }
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

    $.RULE('comparison', () => {
      $.CONSUME(t.Variable)
      $.CONSUME(t.Equals)
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

  if (lexResult.errors.length > 0) {
    const firstError = lexResult.errors[0]
    throw Error(
      'Lexing errors detected in line: ' +
        firstError.line +
        ', column: ' +
        firstError.column +
        '!\n' +
        firstError.message
    )
  }

  const cst = parserInstance[entryPoint]()
  if (parserInstance.errors.length > 0) {
    const error = parserInstance.errors[0]
    throw Error(
      'Parsing errors detected in line: ' +
        error.token.startLine +
        ', column: ' +
        error.token.startColumn +
        '!\n' +
        error.message +
        '!\n\t->' +
        // TODO: should the stack always appear on errors msg?
        error.context.ruleStack.join('\n\t->')
    )
  }

  return cst
}

module.exports = {
  PredicatorParser,
  parserInstance,
  parse,
  BasePredicatorCstVisitor,
  BasePredicatorCstVisitorWithDefaults
}
