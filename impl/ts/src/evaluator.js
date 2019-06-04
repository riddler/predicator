const { toInstructions } = require('./visitors/instructions')

class PredicatorEvaluator {
  constructor (instructions, context = {}) {
    this.instructions = instructions
    this.context = context
    this.stack = []
    this.instructionPointer = 0
  }

  push (val) {
    this.stack.push(val)
  }

  pop () {
    return this.stack.pop()
  }

  result () {
    while (this.instructionPointer < this.instructions.length) {
      this.process(this.instructions[this.instructionPointer])
      this.instructionPointer += 1
    }

    return this.pop()
  }

  process (instruction) {
    const op = instruction[0]
    const val = instruction[1]

    switch (op) {
      case 'not': this.push(!this.pop()); break
      case 'array':
      case 'lit': this.push(val); break
      case 'load': this.push(this.context[val]); break
      case 'jfalse': this.jumpIf(false, val); break
      case 'jtrue': this.jumpIf(true, val); break
      case 'compare': this[`compare_${val}`](); break
      case 'to_bool': this.push(!!this.pop()); break
    }
  }

  jumpIf (bool, offset) {
    if (this.stack[this.stack.length - 1] === bool) {
      this.instructionPointer += (offset - 1)
    } else {
      this.pop()
    }
  }

  compare (comparison) {
    const right = this.pop()
    const left = this.pop()

    if (left === undefined || right === undefined) {
      this.push(false)
    } else {
      this.push(comparison(left, right))
    }
  }

  compare_EQ () {
    return this.compare((left, right) => left === right)
  }

  compare_IN () {
    return this.compare((left, right) => right.indexOf(left) !== -1)
  }

  compare_NOTIN () {
    return this.compare((left, right) => right.indexOf(left) === -1)
  }
}

function evaluateInstructions (instructions, context = {}) {
  const evaluator = new PredicatorEvaluator(instructions, context)
  return evaluator.result()
}

function evaluate (text, context = {}) {
  const instructions = toInstructions(text)
  return evaluateInstructions(instructions, context)
}

module.exports = {
  evaluate,
  evaluateInstructions,
  PredicatorEvaluator
}
