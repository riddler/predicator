
	package predicator

	import (
		"testing"
	)

	// Test_false -- AUTOGENERATED DO NOT EDIT
	func Test_false(t *testing.T) {
		instructions := [][]interface {}{[]interface {}{"lit", false}}
		tt := []struct{
			Name string
			Result bool
			Data   map[string]interface{} 
		}{
		
			{
				"with_no_context",
				false,
				map[string]interface {}(nil),
			},
		
		}
		for _, test := range tt {
			e := NewEvaluator(instructions, test.Data)
			got := e.result()
			if  got != test.Result {
				t.Logf("FAILED %s_%s expected %v got %v", "false", test.Name, test.Result, got)
				t.Fail()
			}
			if e.stack.count > 0 {
				t.Logf("FAILED %s_%s expected empty stack",  "false", test.Name)
				t.Fail()
			}
		}
	}
	