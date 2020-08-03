const { Lexer } = require('chevrotain')
const { tokensArray, tokensDictionary } = require('./tokens')

const predicatorLexer = new Lexer(tokensArray, {
  positionTracking: 'full'
})

function tokenize (text) {
  return predicatorLexer.tokenize(text)
}

module.exports = {
  tokenize,
  tokensDictionary
}
