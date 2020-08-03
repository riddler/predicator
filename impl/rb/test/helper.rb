$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "bundler"
Bundler.setup
require "pry-nav"
require "coveralls"
Coveralls.wear! "test_frameworks"

require "minitest/autorun"
require "minitest/pride"
require "minitest/focus"
require "predicator"
