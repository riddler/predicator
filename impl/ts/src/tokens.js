const { createToken: createTokenOrig, Lexer } = require('chevrotain')

const tokensArray = []
const tokensDictionary = {}

function createToken (options) {
  const newTokenType = createTokenOrig(options)
  tokensArray.push(newTokenType)
  tokensDictionary[options.name] = newTokenType
  return newTokenType
}

createToken({
  name: 'WhiteSpace',
  pattern: /\s+/,
  group: Lexer.SKIPPED
})

createToken({ name: 'Dot', pattern: '.' })

const IBoolean = createToken({ name: 'IBoolean', pattern: Lexer.NA })
const True = createToken({ name: 'True', pattern: /true/, categories: [IBoolean] })
const False = createToken({ name: 'False', pattern: /false/, categories: [IBoolean] })

const IRelationalOperator = createToken({ name: 'IRelationalOperator', pattern: Lexer.NA })
const EQ = createToken({ name: 'EQ', pattern: /=/, categories: [IRelationalOperator] })
const NEQ = createToken({ name: 'NEQ', pattern: /!=/, categories: [IRelationalOperator] })
const GTE = createToken({ name: 'GTE', pattern: />=/, categories: [IRelationalOperator] })
const GT = createToken({ name: 'GT', pattern: />/, categories: [IRelationalOperator] })
const LTE = createToken({ name: 'LTE', pattern: /<=/, categories: [IRelationalOperator] })
const LT = createToken({ name: 'LT', pattern: /</, categories: [IRelationalOperator] })

createToken({ name: 'Or', pattern: /or/ })
createToken({ name: 'And', pattern: /and/ })
const Bang = createToken({ name: 'Bang', pattern: /!/ })
const LParen = createToken({ name: 'LParen', pattern: /\(/ })
const RParen = createToken({ name: 'RParen', pattern: /\)/ })

const IInteger = createToken({ name: 'IInteger', pattern: Lexer.NA })
createToken({
  name: 'DecimalInt', pattern: /-?(0|[1-9]\d*)/, categories: [IInteger]
})

const IVariable = createToken({ name: 'IVariable', pattern: Lexer.NA })
createToken({
  name: 'Variable',
  pattern: /[a-z]\w+(\.[a-z]\w+)*/,
  categories: [IVariable]
})

// Labels only affect error messages and Diagrams.
Bang.LABEL = "'!'"
LParen.LABEL = "'('"
RParen.LABEL = "')'"
EQ.LABEL = "'='"
NEQ.LABEL = "'!='"
GT.LABEL = "'>'"
GTE.LABEL = "'>='"
LT.LABEL = "'<'"
LTE.LABEL = "'<='"

// INSTRUCTION is used when generating instuctions
True.INSTRUCTION = true
False.INSTRUCTION = false
EQ.INSTRUCTION = 'EQ'
NEQ.INSTRUCTION = 'NEQ'
GT.INSTRUCTION = 'GT'
GTE.INSTRUCTION = 'GTE'
LT.INSTRUCTION = 'LT'
LTE.INSTRUCTION = 'LTE'

module.exports = {
  tokensArray,
  tokensDictionary
}
