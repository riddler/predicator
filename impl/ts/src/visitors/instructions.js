const {
  parse,
  BasePredicatorCstVisitorWithDefaults
} = require('../parser')

class PredicatorInstructionsVisitor extends BasePredicatorCstVisitorWithDefaults {
  constructor () {
    super()
    this.validateVisitor()
  }

  accept (cst) {
    this.instructions = []
    this.labelLocations = {}

    this.visit(cst)

    this.updateJumps()
    this.removeLabels()

    return this.instructions
  }


  comparisonForOperator (text) {
    return this.relationalOperators[text]
  }

  jumpLabel () {
    return [...Array(30)].map(() => Math.random().toString(36)[2]).join('')
  }

  updateJumps () {
    this.instructions.forEach((instruction, index) => {
      if (instruction[0].startsWith('j')) {
        var label = instruction.pop()
        var offset = this.calculateOffset(index, this.labelLocations[label])
        instruction.push(offset)
      }
    })
  }

  removeLabels () {
    this.instructions = this.instructions.filter((e) => e[0] !== 'label')
  }

  calculateOffset (fromIndex, toIndex) {
    var offset = toIndex - fromIndex
    var numLabels = this.instructions.slice(fromIndex, toIndex - 1).filter((e) => e[0] === 'label').length
    return offset - numLabels
  }

  addLabel (label) {
    this.labelLocations[label] = this.instructions.length
    this.instructions.push(['label', label])
  }

  not (ctx) {
    this.visit(ctx.predicate)
    this.instructions.push(['not'])
  }

  or (ctx) {
    this.visit(ctx.and)

    if (ctx.predicate) {
      const label = this.jumpLabel()

      ctx.predicate.forEach((predicate, idx) => {
        this.instructions.push(['jtrue', label])
        this.visit(predicate)
      })

      this.addLabel(label)
    }
  }

  and (ctx) {
    this.visit(ctx.atomic)

    if (ctx.predicate) {
      const label = this.jumpLabel()

      ctx.predicate.forEach((predicate, idx) => {
        this.instructions.push(['jfalse', label])
        this.visit(predicate)
      })

      this.addLabel(label)
    }
  }

  atomic (ctx) {
    if (ctx.paren) {
      this.visit(ctx.paren)
    } else if (ctx.not) {
      this.visit(ctx.not)
    } else if (ctx.relationalExpression) {
      this.visit(ctx.relationalExpression)
    } else if (ctx.IBoolean) {
      this.instructions.push([
        'lit',
        ctx.IBoolean[0].tokenType.INSTRUCTION
      ])
    }
  }

  relationalExpression (ctx) {
    this.instructions.push(['load', ctx.Variable[0].image])
    this.instructions.push(['lit', parseInt(ctx.DecimalInt[0].image)])
    this.instructions.push([
      'compare',
      ctx.IRelationalOperator[0].tokenType.INSTRUCTION
    ])
  }
}

const toInstructionsVisitor = new PredicatorInstructionsVisitor()

function compile (text) {
  const cst = parse(text)
  const instructions = toInstructionsVisitor.accept(cst)
  return instructions
}

module.exports = {
  compile,
  toInstructionsVisitor
}
