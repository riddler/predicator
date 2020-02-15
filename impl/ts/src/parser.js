const { tokensDictionary: t, tokenize } = require('./lexer')
const { Parser } = require('chevrotain')


// ListLit     = "[" [ ElementList [ "," ] ] "]" .
// ElementList = Element { "," Element } .
// Element     = Expression | LiteralValue .

// BoolExpr = Expression .


// Operand     = Literal | OperandName | MethodExpr | "(" Expression ")" .
// Literal     = BasicLit | CompositeLit | FunctionLit | RuleLit .
// BasicLit    = int_lit | float_lit | string_lit .
// OperandName = identifier | QualifiedIdent.

// »Primary Expressions
// Primary expressions are the operands for unary and binary expressions.

// PrimaryExpr =
//     Operand |
//     PrimaryExpr Selector |
//     PrimaryExpr Index |
//     PrimaryExpr Slice |
//     PrimaryExpr Arguments .

// Selector  = "." identifier .



class PredicatorParser extends Parser {
  constructor () {
    super(t, {
      recoveryEnabled: true
    })

    const $ = this

// Expression = UnaryExpr | Expression binary_op Expression .
// UnaryExpr  = PrimaryExpr | unary_op UnaryExpr .

    $.RULE('booleanExpression', () => {
      $.SUBRULE($.orExpression)
    })

    $.RULE('orExpression', () => {
      $.SUBRULE($.andExpression)
      $.MANY(() => {
        $.CONSUME(t.Or)
        $.SUBRULE2($.booleanExpression)
      })
    })

    $.RULE('andExpression', () => {
      $.SUBRULE($.booleanOperand)
      $.MANY(() => {
        $.CONSUME(t.And)
        $.SUBRULE2($.booleanExpression)
      })
    })

        // { ALT: () => $.SUBRULE($.paren) },
        // { ALT: () => $.SUBRULE($.not) },
        // { ALT: () => $.SUBRULE($.relationalExpression) },
        // // { ALT: () => $.SUBRULE($.betweenExpression) },

    // A BooleanOperand is the basic value of a BooleanExpression
    $.RULE('booleanOperand', () => {
      $.OR([
        { ALT: () => $.SUBRULE($.variable) },
        { ALT: () => $.CONSUME(t.IBoolean) },
        { ALT: () => $.SUBRULE($.booleanNot) },
        { ALT: () => $.SUBRULE($.booleanGroup) }
      ])
    })

    $.RULE('variable', () => {
      $.CONSUME(t.Variable)
      $.OPTION(() => {
        $.CONSUME(t.ColonColon)
        $.CONSUME(t.IDataType)
      });
    })

    $.RULE('booleanNot', () => {
      $.OR([
        { ALT: () => $.CONSUME(t.Exclamation) },
        { ALT: () => $.CONSUME(t.Not) },
      ])
      $.SUBRULE($.booleanExpression)
    })

    $.RULE('booleanGroup', () => {
      $.CONSUME(t.LParen)
      $.SUBRULE($.booleanExpression)
      $.CONSUME(t.RParen)
    })


    // $.RULE('UnaryExpression', () => {
    //   $.OR([
    //     // { ALT: () => $.SUBRULE($.PrimaryExpression) },
    //     { ALT: () => {
    //       $.CONSUME(t.IUnaryOperator)
    //       $.SUBRULE($.UnaryExpression)
    //     }}
    //   ])
    // })

    this.performSelfAnalysis()
  }
}


// class OldPredicatorParser extends Parser {
//   constructor () {
//     super(t, {
//       recoveryEnabled: true
//     })

//     const $ = this

//     $.RULE('predicate', () => {
//       $.SUBRULE($.or)
//     })

//     $.RULE('or', () => {
//       $.SUBRULE($.and)
//       $.MANY(() => {
//         $.CONSUME(t.Or)
//         $.SUBRULE2($.predicate)
//       })
//     })

//     $.RULE('and', () => {
//       $.SUBRULE($.operand)
//       $.MANY(() => {
//         $.CONSUME(t.And)
//         $.SUBRULE2($.predicate)
//       })
//     })

//     // An Operand is the basic value of an expression - it may be a literal or a variable
//     $.RULE('operand', () => {
//       $.OR([
//         { ALT: () => $.SUBRULE($.paren) },
//         { ALT: () => $.SUBRULE($.not) },
//         { ALT: () => $.SUBRULE($.relationalExpression) },
//         // { ALT: () => $.SUBRULE($.betweenExpression) },
//         { ALT: () => $.SUBRULE($.variable) },
//         { ALT: () => $.CONSUME(t.IBoolean) }
//       ])
//     })





//     $.RULE('variable', () => {
//       $.CONSUME(t.Variable)
//       $.OPTION(() => {
//         $.CONSUME(t.ColonColon)
//         $.CONSUME(t.IType)
//       });
//     })

//     $.RULE('paren', () => {
//       $.CONSUME(t.LParen)
//       $.SUBRULE($.predicate)
//       $.CONSUME(t.RParen)
//     })

//     $.RULE('not', () => {
//       $.OR([
//         { ALT: () => $.CONSUME(t.Exclamation) },
//         { ALT: () => $.CONSUME(t.Not) },
//       ])
//       $.SUBRULE($.predicate)
//     })


//     $.RULE('relationalExpression', () => {
//       $.CONSUME(t.Variable)
//       $.CONSUME(t.IRelationalOperator)
//       $.OR([
//         { ALT: () => $.CONSUME(t.IDate) },
//         { ALT: () => $.CONSUME(t.IInteger) },
//         { ALT: () => $.CONSUME(t.IString) }
//       ])
//     })

//     $.RULE('relationalExpression', () => {
//       $.CONSUME(t.Variable)
//       $.CONSUME(t.IRelationalOperator)
//       $.OR([
//         { ALT: () => $.CONSUME(t.IDate) },
//         { ALT: () => $.CONSUME(t.IInteger) },
//         { ALT: () => $.CONSUME(t.IString) }
//       ])
//     })

//     // $.RULE('betweenExpression', () => {
//     //   $.OR([
//     //     { ALT: () => $.SUBRULE($.betweenIntExpression) }
//     //   ])
//     // })

//     // $.RULE('betweenIntExpression', () => {
//     //   $.CONSUME(t.Variable)
//     //   $.CONSUME(t.Between)
//     //   $.CONSUME(t.IInteger)
//     //   $.CONSUME(t.And)
//     //   $.CONSUME1(t.IInteger)
//     // })

//     this.performSelfAnalysis()
//   }
// }

const parserInstance = new PredicatorParser()
const BasePredicatorCstVisitor = parserInstance.getBaseCstVisitorConstructor()
const BasePredicatorCstVisitorWithDefaults = parserInstance.getBaseCstVisitorConstructorWithDefaults()

function parse (inputText, entryPoint = 'booleanExpression') {
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
