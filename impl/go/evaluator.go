package predicator

import (
	"errors"
)

func NewEvaluator(instructions [][]interface{}, data map[string]interface{}) *Evaluator {
	e := Evaluator{
		instructions: instructions,
		data:         data,
		stack:        &stack{},
	}
	return &e
}

type Evaluator struct {
	instructions [][]interface{}
	data         map[string]interface{}
	stack        *stack
	ip           int
}

type stack struct {
	nodes []interface{}
	count int
}

func (s *stack) pop() interface{} {
	if s.count == 0 {
		return nil
	}
	s.count--
	return s.nodes[s.count]
}

func (s *stack) push(v interface{}) {
	s.nodes = append(s.nodes[:s.count], v)
	s.count++
}

func (s *stack) peek() interface{} {
	if s.count == 0 {
		return nil
	}
	return s.nodes[s.count-1]
}

const (
	InstructionNot         = "not"
	InstructionJumpIfFalse = "jfalse"
	InstructionJumpIfTrue  = "jtrue"
	InstructionLiteral     = "lit"
	InstructionArray       = "array"
	InstructionLoad        = "load"
	InstructionToBool      = "to_bool"
	InstructionToInt       = "to_int"
	InstructionToString    = "to_str"
	InstructionToDate      = "to_date"
	InstructionDateAgo     = "date_ago"
	InstructionDateFromNow = "date_from_now"
	InstructionBlank       = "blank"
	InstructionPresent     = "present"
	InstructionCompare     = "compare"

	KeywordCompareBetween = "BETWEEN"
	KeywordCompareEqual   = "EQ"
	KeywordCompareInclude = "IN"
)

var (
	ErrInvalidInstruction = errors.New("invalid instruction")
)

func (e *Evaluator) result() (output bool) {
	defer func() {
		r := recover()
		if r != nil {
			// fmt.Println("recovered: ", r)
			output = false
		}
	}()
	for e.ip < len(e.instructions) {
		e.process(e.instructions[e.ip])
		e.ip = e.ip + 1
	}
	return e.stack.pop().(bool)
}

func (e *Evaluator) process(instruction []interface{}) error {
	i, ok := instruction[0].(string)
	if !ok {
		return ErrInvalidInstruction
	}
	switch i {
	case InstructionNot:
		v, ok := e.stack.pop().(bool)
		if !ok {
			return ErrInvalidInstruction
		}
		e.stack.push(!v)
	case InstructionJumpIfFalse:
		offset, ok := instruction[len(instruction)-1].(int)
		if !ok {
			return ErrInvalidInstruction
		}
		e.jumpIfFalse(offset)
	case InstructionJumpIfTrue:
		offset, ok := instruction[len(instruction)-1].(int)
		if !ok {
			return ErrInvalidInstruction
		}
		e.jumpIfTrue(offset)
	case InstructionLiteral, InstructionArray:
		e.stack.push(instruction[len(instruction)-1])
	case InstructionLoad:
		key, ok := instruction[len(instruction)-1].(string)
		if !ok {
			return ErrInvalidInstruction
		}
		v, ok := e.data[key]
		if !ok {
			return ErrInvalidInstruction
		}
		e.stack.push(v)
	case InstructionToBool:
	case InstructionToInt:
	case InstructionToString:
	case InstructionToDate:
	case InstructionDateAgo:
	case InstructionDateFromNow:
	case InstructionBlank:
	case InstructionPresent:
	case InstructionCompare:
		if instruction[len(instruction)-1] == KeywordCompareBetween {
			// compare_between
		} else {
			v, ok := instruction[len(instruction)-1].(string)
			if !ok {
				return ErrInvalidInstruction
			}
			e.compare(v)
		}
	}
	return nil
}

func (e *Evaluator) jumpIfFalse(offset int) {
	b, ok := e.stack.peek().(bool)
	if ok {
		if !b {
			e.ip += offset - 1
			return
		}
	}
	e.stack.pop()
}

func (e *Evaluator) jumpIfTrue(offset int) {
	b, ok := e.stack.peek().(bool)
	if ok {
		if b {
			e.ip += offset - 1
			return
		}
	}
	e.stack.pop()
}

func (e *Evaluator) compare(comparison string) {
	right := e.stack.pop()
	left := e.stack.pop()
	// fmt.Println("comp", comparison, right, left)
	if left == nil || right == nil {
		e.stack.push(false)
	} else {
		switch comparison {
		case KeywordCompareEqual:
			e.stack.push(e.compareEquality(left, right))
		case KeywordCompareInclude:
			e.stack.push(e.compareInclude(left, right))
		default:
			e.stack.push(false)
		}
	}
}

func (e *Evaluator) compareEquality(left, right interface{}) bool {
	return left == right
}

func (e *Evaluator) compareInclude(left, right interface{}) bool {
	xs, ok := right.([]interface{})
	if !ok {
		return false
	}
	for _, x := range xs {
		if left == x {
			return true
		}
	}
	return false

}
