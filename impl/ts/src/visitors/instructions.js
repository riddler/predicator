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

  booleanNot (ctx) {
    this.visit(ctx.booleanExpression)
    this.instructions.push(['not'])
  }

  orExpression (ctx) {
    this.visit(ctx.andExpression)

    if (ctx.booleanExpression) {
      const label = this.jumpLabel()

      ctx.booleanExpression.forEach((booleanExpression, idx) => {
        this.instructions.push(['jtrue', label])
        this.visit(booleanExpression)
      })

      this.addLabel(label)
    }
  }

  andExpression (ctx) {
    this.visit(ctx.booleanOperand)

    if (ctx.booleanExpression) {
      const label = this.jumpLabel()

      ctx.booleanExpression.forEach((booleanExpression, idx) => {
        this.instructions.push(['jfalse', label])
        this.visit(booleanExpression)
      })

      this.addLabel(label)
    }
  }

  booleanOperand (ctx) {
    if (ctx.booleanGroup) {
      this.visit(ctx.booleanGroup)

    } else if (ctx.booleanNot) {
      this.visit(ctx.booleanNot)

    } else if (ctx.relationalExpression) {
      this.visit(ctx.relationalExpression)


    // } else if (ctx.betweenExpression) {
    //   this.visit(ctx.betweenExpression)

    } else if (ctx.IBoolean) {
      this.instructions.push([
        'lit',
        ctx.IBoolean[0].image.toLowerCase() === 'true'
      ])
    } else if (ctx.variable) {
      this.visit(ctx.variable)

      const previousInstruction = this.instructions[this.instructions.length-1]
      if (previousInstruction[0] !== 'to_bool') {
        this.instructions.push(['to_bool'])
      }
    }
  }

  variable (ctx) {
    this.instructions.push(['load', ctx.Variable[0].image])
    if (ctx.TypeCast) {
      const operation = 'to_' + ctx.IDataType[0].image.toLowerCase
      this.instructions.push([operation])
    }
  }

  // matchesExpression (ctx) {
  //   ctx.expression.forEach((expression, idx) => {
  //     this.visit(expression)
  //   })

  //   this.instructions.push([ctx.IMatchesOperator[0].tokenType.INSTRUCTION])
  // }

  // setExpression (ctx) {
  //   ctx.expression.forEach((expression, idx) => {
  //     this.visit(expression)
  //   })

  //   this.instructions.push([ctx.ISetOperator[0].tokenType.INSTRUCTION])
  // }

  relationalExpression (ctx) {
    ctx.expression.forEach((expression, idx) => {
      this.visit(expression)
    })

    console.log("relationalExpression", ctx.expression[0].children)
    if (ctx.IRelationalOperator) {
      this.instructions.push([
        'compare',
        this.comparisonForOperator(ctx.IRelationalOperator[0])
      ])

    } else if (ctx.IMatchesOperator) {
      this.instructions.push([ctx.IMatchesOperator[0].tokenType.INSTRUCTION])

    } else if (ctx.ISetOperator) {
      this.instructions.push([ctx.ISetOperator[0].tokenType.INSTRUCTION])
    }
  }

  expression (ctx) {
    if (ctx.operand) {
      this.visit(ctx.operand)
    } else if (ctx.list) {
      this.visit(ctx.list)
    }
  }

  list (ctx) {
    const array = []
    ctx.operand.forEach((operand, idx) => {
      console.log("list", operand.children)
      array.push(this.extractOperandValue(operand.children))
    })
    this.instructions.push(['lit', array])
  }

  operand (ctx) {
    this.instructions.push(['lit', this.extractOperandValue(ctx)])
  }

  extractOperandValue (ctx) {
    console.log("extractOperandValue",ctx)
    if (ctx.IInteger) {
      return parseInt(ctx.IInteger[0].image)

    } else if (ctx.IString) {
      const str = ctx.IString[0].image
      return str.substring(1, str.length-1)
    // } else if (ctx.IDate) {
    //   this.instructions.push(['to_date'])
    //   this.instructions.push(['lit', ctx.IDate[0].image])
    //   this.instructions.push(['to_date'])
    }
  }

  comparisonForOperator (operator) {
    if (operator.COMPARISON) {
      return operator.COMPARISON
    }

    return operator.image
  }

  jumpLabel () {
    return [...Array(30)].map(() => Math.random().toString(36)[2]).join('')
  }

  updateJumps () {
    this.instructions.forEach((instruction, index) => {
      if (instruction[0] && instruction[0].startsWith('j')) {
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





  // betweenExpression (ctx) {
  //   if (ctx.betweenIntExpression) {
  //     this.visit(ctx.betweenIntExpression)

  //   }
  // }

  // betweenIntExpression (ctx) {
  //   this.instructions.push(['load', ctx.Variable[0].image])

  //   this.instructions.push(['to_int'])
  //   ctx.IInteger.map((intNode) => {
  //     this.instructions.push(['lit', parseInt(intNode.image)])
  //   })

  //   this.instructions.push(['compare', 'BETWEEN'])
  // }
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
