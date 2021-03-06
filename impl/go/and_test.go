
	package predicator

	import (
		"testing"
	)

	// Test_and -- AUTOGENERATED DO NOT EDIT
	func Test_and(t *testing.T) {
		instructions := [][]interface {}{[]interface {}{"lit", true}, []interface {}{"jfalse", 2}, []interface {}{"lit", true}}
		tt := []struct{
			Name string
			Result bool
			Data   map[string]interface{} 
		}{
		
			{
				"with_no_context",
				true,
				map[string]interface {}(nil),
			},
		
		}
		for _, test := range tt {
			e := NewEvaluator(instructions, test.Data)
			got := e.result()
			if  got != test.Result {
				t.Logf("FAILED %s_%s expected %v got %v", "and", test.Name, test.Result, got)
				t.Fail()
			}
			if e.stack.count > 0 {
				t.Logf("FAILED %s_%s expected empty stack",  "and", test.Name)
				t.Fail()
			}
		}
	}
	