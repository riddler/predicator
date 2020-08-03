package predicator

import (
	"testing"
)

// instructions [][]interface{}, data map[string]interface{}
func TestLit(t *testing.T) {
	e := NewEvaluator([][]interface{}{
		[]interface{}{
			"lit",
			true,
		},
	}, nil)
	if e.result() != true {
		t.Fail()
	}
}

func TestNot(t *testing.T) {
	e := NewEvaluator([][]interface{}{
		[]interface{}{
			"lit",
			true,
		},
		[]interface{}{
			"not",
		},
	}, nil)
	if e.result() != false {
		t.Fail()
	}
}

func TestJumpIfFalse(t *testing.T) {
	e := NewEvaluator([][]interface{}{
		[]interface{}{
			"lit",
			true,
		},
		[]interface{}{
			"jfalse",
			2,
		},
		[]interface{}{
			"lit",
			true,
		},
	}, nil)
	if e.result() != true {
		t.Fail()
	}
	if e.stack.count > 0 {
		t.Fail()
	}
}
