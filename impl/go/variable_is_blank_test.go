
	package predicator

	import (
		"testing"
	)

	// Test_variable_is_blank -- AUTOGENERATED DO NOT EDIT
	func Test_variable_is_blank(t *testing.T) {
		instructions := [][]interface {}{[]interface {}{"load", "foo"}, []interface {}{"blank"}}
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
		
			{
				"with_blank_string",
				true,
				map[string]interface {}{"foo":""},
			},
		
			{
				"with_int",
				false,
				map[string]interface {}{"foo":1},
			},
		
			{
				"with_string",
				false,
				map[string]interface {}{"foo":"bar"},
			},
		
		}
		for _, test := range tt {
			e := NewEvaluator(instructions, test.Data)
			got := e.result()
			if  got != test.Result {
				t.Logf("FAILED %s_%s expected %v got %v", "variable_is_blank", test.Name, test.Result, got)
				t.Fail()
			}
			if e.stack.count > 0 {
				t.Logf("FAILED %s_%s expected empty stack",  "variable_is_blank", test.Name)
				t.Fail()
			}
		}
	}
	