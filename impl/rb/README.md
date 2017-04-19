[![Gem Version](https://badge.fury.io/rb/predicator.svg)](http://badge.fury.io/rb/predicator)
[![Build Status](https://travis-ci.org/johnnyt/predicator.svg?branch=master)](https://travis-ci.org/johnnyt/predicator)
[![Dependency Status](https://img.shields.io/gemnasium/johnnyt/predicator.svg)](https://gemnasium.com/johnnyt/predicator)
[![Coverage Status](https://coveralls.io/repos/github/johnnyt/predicator/badge.svg?branch=master)](https://coveralls.io/github/johnnyt/predicator?branch=master)

# Predicator

Predicator is a predicate engine.

## Usage

Example usage:

```ruby
require "predicator"

Predicator.evaluate "1 = 2"
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
Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johnnyt/predicator.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
