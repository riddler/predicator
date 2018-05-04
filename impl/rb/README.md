[![Gem Version](https://badge.fury.io/rb/predicator.svg)](http://badge.fury.io/rb/predicator)
[![Build Status](https://travis-ci.org/predicator/predicator.svg?branch=master)](https://travis-ci.org/predicator/predicator)
[![Dependency Status](https://img.shields.io/gemnasium/predicator/predicator.svg)](https://gemnasium.com/predicator/predicator)
[![Coverage Status](https://coveralls.io/repos/github/predicator/predicator/badge.svg?branch=master)](https://coveralls.io/github/predicator/predicator?branch=master)

# Predicator

Predicator is a safe (does not eval code), admin or business user facing predicate engine. It turns a string predicate like `"score > 600 or (score > 580 and monthly_income > 9000)"` along with a supplied context into a `true` or `false`. This predicate can be stored as an attribute of a model (ex: an Offer model could store a predicate indicating if it is available to a customer).

## Usage

Simple usage:

```ruby
require "predicator"

Predicator.evaluate "score > 600 or (score > 580 and income > 9000)", score: 590 # false

Predicator.evaluate "score > 600 or (score > 580 and income > 9000)", score: 590, income: 9500 # true
```

Example usage with a model:

```ruby
class Customer
  ...
  def to_hash
    {
      ...
      score: score,
      income: income,
      ...
    }
  end
end

class Offer
  attr_accessor :available_predicate
  
  ...
  
  def available_to? customer
    Predicator.evaluate available_predicate, customer.to_hash
  end
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "predicator"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install predicator

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` (or just `rake`) to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/predicator/predicator.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
