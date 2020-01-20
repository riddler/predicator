const { createToken: buildToken, Lexer } = require('chevrotain')

const allTokens = []
const keywordTokens = []
const tokensDictionary = {}

function addToken (token) {
  allTokens.push(token)
  tokensDictionary[token.name] = token
}

const createToken = function() {
  const newToken = buildToken.apply(null, arguments)
  addToken(newToken)
  return newToken
}

const createKeywordToken = function(config) {
  config.longer_alt = Variable
  const newToken = createToken(config)
  keywordTokens.push(newToken)
  newToken.CATEGORIES.push(Keyword)
  return newToken
}


//-----
//-----[ Ignored Tokens ]----------------------------------------
//-----

createToken({
  name: "WhiteSpace",
  pattern: /[ \t]+/,
  group: Lexer.SKIPPED
})

createToken({
  name: "LineTerminator",
  pattern: /\n\r|\r|\n/,
  group: Lexer.SKIPPED
})

createToken({
  name: "Comment",
  pattern: /#[^\n\r]*/,
  group: Lexer.SKIPPED
})

createToken({
  name: "Comma",
  pattern: ",",
  group: Lexer.SKIPPED
})

//-----
//-----[ Lexical Tokens ]----------------------------------------
//-----

// Punctuation
createToken({ name: "Exclamation", pattern: "!" })
createToken({ name: "LParen", pattern: "(" })
createToken({ name: "RParen", pattern: ")" })
createToken({ name: "Dot", pattern: "." })
createToken({ name: "ColonColon", pattern: /::/ })

// Identifiers (Variables) and Keywords
// We need to create the Identifier, but can not add it to the Token list
// until all other Keywords have been added.
// This is why buildToken is used (not createToken which adds them to the list)

// const Identifier = buildToken({
//   name: 'Identifier',
//   pattern: /[a-z][_0-9A-Za-z]+/
// })

const Variable = buildToken({
  name: "Variable",
  pattern: /[a-z][_0-9A-Za-z]*(?:\.[a-z][_0-9A-Za-z]*)*/
})

const Keyword = createToken({ name: "Keyword", pattern: Lexer.NA })

// const ILiteral = createToken({ name: "Literal", pattern: Lexer.NA })

const IBoolean = createToken({ name: 'IBoolean', pattern: Lexer.NA })

const IType = createToken({ name: 'IType', pattern: Lexer.NA })

// Constant Literals
createKeywordToken({ name: "True", pattern: "true", categories: [IBoolean] })
createKeywordToken({ name: "False", pattern: "false", categories: [IBoolean] })
createKeywordToken({ name: "Null", pattern: "null" })
createKeywordToken({ name: "Undefined", pattern: "undefined" })

// Keywords
createKeywordToken({ name: 'Bool', pattern: /bool/, categories: [IType] })
createKeywordToken({ name: 'Or', pattern: /or/ })
createKeywordToken({ name: 'And', pattern: /and/ })

// Now that all the keywords have been defined, manually add the Variable
addToken(Variable)



// const Query = createKeywordToken({ name: "Query", pattern: "query" })
// const Mutation = createKeywordToken({
//   name: "Mutation",
//   pattern: "mutation"
// })
// const Subscription = createKeywordToken({
//   name: "Subscription",
//   pattern: "subscription"
// })
// const Fragment = createKeywordToken({
//   name: "Fragment",
//   pattern: "fragment"
// })
// const On = createKeywordToken({ name: "On", pattern: "on" })
// const True = createKeywordToken({ name: "True", pattern: "true" })
// const False = createKeywordToken({ name: "False", pattern: "false" })
// const Null = createKeywordToken({ name: "Null", pattern: "null" })
// const Schema = createKeywordToken({ name: "Schema", pattern: "schema" })
// const Extend = createKeywordToken({ name: "Extend", pattern: "extend" })
// const Scalar = createKeywordToken({ name: "Scalar", pattern: "scalar" })
// const Implements = createKeywordToken({
//   name: "Implements",
//   pattern: "implements"
// })
// const Interface = createKeywordToken({
//   name: "Interface",
//   pattern: "interface"
// })
// const Union = createKeywordToken({ name: "Union", pattern: "Union" })
// const Enum = createKeywordToken({ name: "Enum", pattern: "enum" })
// const Input = createKeywordToken({ name: "Input", pattern: "Input" })
// const DirectiveTok = createKeywordToken({
//   name: "DirectiveTok",
//   pattern: "directive"
// })
// const TypeTok = createKeywordToken({ name: "TypeTok", pattern: "type" })




// const Colon = createToken({ name: "Colon", pattern: ":" })
// const Equals = createToken({ name: "Equals", pattern: "=" })
// const At = createToken({ name: "At", pattern: "@" })
// const LSquare = createToken({ name: "LSquare", pattern: "[" })
// const RSquare = createToken({ name: "RSquare", pattern: "]" })
// const LCurly = createToken({ name: "LCurly", pattern: "{" })
// const VerticalLine = createToken({ name: "VerticalLine", pattern: "|" })
// const RCurly = createToken({ name: "RCurly", pattern: "}" })


// function createAndAddToken (options) {
//   const newTokenType = createToken(options)
//   addToken(newTokenType)
//   return newTokenType
// }


// createAndAddToken({ name: 'Dot', pattern: '.' })
// createAndAddToken({
//   name: 'Variable',
//   pattern: /[a-z]\w+(\.[a-z]\w+)*/,
//   categories: [IVariable]
// })



// // We need to create the Identifier early, but add it last
// // See https://github.com/SAP/chevrotain/blob/master/examples/lexer/keywords_vs_identifiers/keywords_vs_identifiers.js
// Identifier = createToken({
//   name: 'Identifier',
//   pattern: /[a-z]\w+/
// })





// createAndAddToken({ name: 'Dot', pattern: '.' })
// createAndAddToken({
//   name: 'Variable',
//   pattern: /[a-z]\w+(\.[a-z]\w+)*/,
//   categories: [IVariable]
// })



////
//// Constants
////
//const IBoolean = createAndAddToken({ name: 'IBoolean', pattern: Lexer.NA })
//const LitTrue = createAndAddToken({ name: 'True', pattern: /true/, categories: [IBoolean], longer_alt: Identifier })
//const LitFalse = createAndAddToken({ name: 'False', pattern: /false/, categories: [IBoolean], longer_alt: Identifier })
//LitUndefined = createAndAddToken({ name: 'Undefined', pattern: /undefined/, longer_alt: Identifier })
//LitNull = createAndAddToken({ name: 'Null', pattern: /null/, longer_alt: Identifier })




// const IRelationalOperator = createAndAddToken({ name: 'IRelationalOperator', pattern: Lexer.NA })
// const EQ = createAndAddToken({ name: 'EQ', pattern: /=/, categories: [IRelationalOperator] })
// const NEQ = createAndAddToken({ name: 'NEQ', pattern: /!=/, categories: [IRelationalOperator] })
// const GTE = createAndAddToken({ name: 'GTE', pattern: />=/, categories: [IRelationalOperator] })
// const GT = createAndAddToken({ name: 'GT', pattern: />/, categories: [IRelationalOperator] })
// const LTE = createAndAddToken({ name: 'LTE', pattern: /<=/, categories: [IRelationalOperator] })
// const LT = createAndAddToken({ name: 'LT', pattern: /</, categories: [IRelationalOperator] })


// createAndAddToken({ name: 'Or', pattern: /or/ })
// createAndAddToken({ name: 'And', pattern: /and/ })
// createAndAddToken({ name: 'Between', pattern: /between/ })
// const Bang = createAndAddToken({ name: 'Bang', pattern: /!/ })
// const LParen = createAndAddToken({ name: 'LParen', pattern: /\(/ })
// const RParen = createAndAddToken({ name: 'RParen', pattern: /\)/ })



// const IDate = createAndAddToken({ name: 'IDate', pattern: Lexer.NA })
// createAndAddToken({
//   name: 'Date',
//   pattern: /\d{4}[-/]\d{2}[-/]\d{2}/,
//   categories: [IDate]
// })

// const IInteger = createAndAddToken({ name: 'IInteger', pattern: Lexer.NA })
// createAndAddToken({
//   name: 'DecimalInt', pattern: /-?(0|[1-9]\d*)/, categories: [IInteger]
// })


// const IString = createAndAddToken({ name: 'IString', pattern: Lexer.NA })
// createAndAddToken({
//   name: 'String',
//   pattern: /(["'])([^\1]*)\1/,
//   categories: [IString]
// })

// // Labels only affect error messages and Diagrams.
// Bang.LABEL = "'!'"
// LParen.LABEL = "'('"
// RParen.LABEL = "')'"

// EQ.LABEL = "'='"
// NEQ.LABEL = "'!='"
// GT.LABEL = "'>'"
// GTE.LABEL = "'>='"
// LT.LABEL = "'<'"
// LTE.LABEL = "'<='"

// // INSTRUCTION is used when generating instuctions
// True.INSTRUCTION = true
// False.INSTRUCTION = false

// EQ.INSTRUCTION = 'EQ'
// NEQ.INSTRUCTION = 'NEQ'
// GT.INSTRUCTION = 'GT'
// GTE.INSTRUCTION = 'GTE'
// LT.INSTRUCTION = 'LT'
// LTE.INSTRUCTION = 'LTE'




module.exports = {
  tokensArray: allTokens,
  tokensDictionary
}
