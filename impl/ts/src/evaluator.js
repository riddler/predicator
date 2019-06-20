const { compile } = require('./visitors/instructions')

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
      case 'to_int': this.push(parseInt(this.pop())); break
      case 'to_date': this.push(this.toDate(this.pop())); break
      case 'to_str': this.push(this.toString(this.pop())); break
      case 'date_ago': this.dateAgo(); break
      case 'date_from_now': this.dateFromNow(); break
      case 'blank': this.push(this.isBlank(this.pop())); break
      case 'present': this.push(!this.isBlank(this.pop())); break
    }
  }

  isBlank (val) {
    return (val === undefined || val === "")
  }

  toString (val) {
    return val
  }

  toDate (val) {
    return (new Date(val)).getTime()
  }

  dateAgo () {
    const seconds = parseInt(this.pop())
    const pastTimestamp = Date.now() - (seconds * 1000)
    this.push(this.toDate(pastTimestamp))
  }

  dateFromNow () {
    const seconds = parseInt(this.pop())
    const futureTimestamp = Date.now() + (seconds * 1000)
    this.push(this.toDate(futureTimestamp))
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

  compare_NEQ () {
    return this.compare((left, right) => left !== right)
  }

  compare_GT () {
    return this.compare((left, right) => left > right)
  }

  compare_GTE () {
    return this.compare((left, right) => left >= right)
  }

  compare_LT () {
    return this.compare((left, right) => left < right)
  }

  compare_LTE () {
    return this.compare((left, right) => left <= right)
  }

  compare_IN () {
    return this.compare((left, right) => right.indexOf(left) !== -1)
  }

  compare_NOTIN () {
    return this.compare((left, right) => right.indexOf(left) === -1)
  }

  compare_BETWEEN () {
    const max = this.pop()
    const min = this.pop()
    const val = this.pop()

    if (max === undefined || min === undefined || val === undefined) {
      this.push(false)
    } else {
      const result = (val > min) && (val < max)
      this.push(result)
    }
  }

}

function evaluateInstructions (instructions, context = {}) {
  const evaluator = new PredicatorEvaluator(instructions, context)
  return evaluator.result()
}

function evaluate (text, context = {}) {
  const instructions = compile(text)
  return evaluateInstructions(instructions, context)
}

module.exports = {
  evaluate,
  evaluateInstructions,
  PredicatorEvaluator
}
