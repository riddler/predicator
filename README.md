[![Build Status](https://travis-ci.org/riddler/predicator-js.svg?branch=master)](https://travis-ci.org/riddler/predicator-js)
[![Maintainability](https://api.codeclimate.com/v1/badges/2e21756aaa54c2073d29/maintainability)](https://codeclimate.com/github/riddler/predicator-js/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/2e21756aaa54c2073d29/test_coverage)](https://codeclimate.com/github/riddler/predicator-js/test_coverage)

# Predicator

Predicator is a safe (does not eval code), admin or business user facing predicate engine. It turns a string predicate like `"score > 600 or (score > 580 and monthly_income > 9000)"` along with a supplied context into a `true` or `false`. This predicate can be stored as an attribute of a model (ex: an Offer model could store a predicate indicating if it is available to a customer).

## Usage

Simple usage:

```js
const Predicator = import('predicator')

Predicator.evaluate('score = 600 or (score = 580 and income = 9000)', {score: 600}) // true

Predicator.evaluate('score = 600 or (score = 580 and income = 9000)', {score: 580}) // false

Predicator.evaluate('score = 600 or (score = 580 and income = 9000)', {score: 580, income: 9000}) // true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/riddler/predicator-js.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
