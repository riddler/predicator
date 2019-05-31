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
createToken({ name: 'True', pattern: /true/, categories: [IBoolean] })
createToken({ name: 'False', pattern: /false/, categories: [IBoolean] })

const IOperator = createToken({ name: 'IOperator', pattern: Lexer.NA })
const Equals = createToken({ name: 'Equals', pattern: /=/, categories: [IOperator] })

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
Equals.LABEL = "'='"

module.exports = {
  tokensArray,
  tokensDictionary
}
