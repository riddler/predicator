# Predicator

Predicator is a safe (does not eval code), admin or business user facing predicate engine. It turns a string predicate like `"score >= 600 or (score > 580 and monthly_income > 9000)"` along with a supplied context into a `true` or `false`. This predicate can be stored as an attribute of a model (ex: an Offer model could store a predicate indicating if it is available to a customer).

This project provides a Go Evaluator - the parsing and compilation needs to happen in Ruby or JavaScript.

## Usage

Assuming Predicator compiled the string `score >= 600 or (score > 580 and income > 9000)` to the instructions:

```json
[
  [ "load", "score" ],
  [ "to_int" ],
  [ "lit", 600 ],
  [ "compare", "GTE" ],
  [ "jtrue", 11 ],
  [ "load", "score" ],
  [ "to_int" ],
  [ "lit", 580 ],
  [ "compare", "GT" ],
  [ "jfalse", 5 ],
  [ "load", "income" ],
  [ "to_int" ],
  [ "lit", 9000 ],
  [ "compare", "GT" ]
]
```

Simple usage:

```go
data := make(map[string]interface{}, 8)
e := NewEvaluator(instructions, data)
result := e.result()
// result is now set to false
```

Now add data to make the predicate pass:

```go
data := make(map[string]interface{}, 8)
data["score"] = 590;
data["income"] = 9500;
e := NewEvaluator(instructions, data)
result := e.result()
// result is now set to false
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/riddler/predicator-go.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
