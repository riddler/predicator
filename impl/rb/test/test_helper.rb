$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "coveralls"
require "minitest/autorun"
require "minitest/pride"

Coveralls.wear!
require "predicator"
