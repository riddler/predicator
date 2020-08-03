
	package predicator

	import (
		"testing"
	)

	// Test_variable_eq_string -- AUTOGENERATED DO NOT EDIT
	func Test_variable_eq_string(t *testing.T) {
		instructions := [][]interface {}{[]interface {}{"load", "plan"}, []interface {}{"to_str"}, []interface {}{"lit", "basic"}, []interface {}{"compare", "EQ"}}
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
		
			{
				"with_blank_string",
				false,
				map[string]interface {}{"plan":""},
			},
		
			{
				"with_correct_string",
				true,
				map[string]interface {}{"plan":"basic"},
			},
		
			{
				"with_incorrect_string",
				false,
				map[string]interface {}{"plan":"free"},
			},
		
			{
				"with_int",
				false,
				map[string]interface {}{"plan":1},
			},
		
			{
				"with_false",
				false,
				map[string]interface {}{"plan":false},
			},
		
			{
				"with_true",
				false,
				map[string]interface {}{"plan":true},
			},
		
		}
		for _, test := range tt {
			e := NewEvaluator(instructions, test.Data)
			got := e.result()
			if  got != test.Result {
				t.Logf("FAILED %s_%s expected %v got %v", "variable_eq_string", test.Name, test.Result, got)
				t.Fail()
			}
			if e.stack.count > 0 {
				t.Logf("FAILED %s_%s expected empty stack",  "variable_eq_string", test.Name)
				t.Fail()
			}
		}
	}
	