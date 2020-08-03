
	package predicator

	import (
		"testing"
	)

	// Test_int_in_array -- AUTOGENERATED DO NOT EDIT
	func Test_int_in_array(t *testing.T) {
		instructions := [][]interface {}{[]interface {}{"lit", 1}, []interface {}{"array", []interface {}{1, 2}}, []interface {}{"compare", "IN"}}
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
				t.Logf("FAILED %s_%s expected %v got %v", "int_in_array", test.Name, test.Result, got)
				t.Fail()
			}
			if e.stack.count > 0 {
				t.Logf("FAILED %s_%s expected empty stack",  "int_in_array", test.Name)
				t.Fail()
			}
		}
	}
	