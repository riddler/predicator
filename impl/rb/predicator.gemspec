# coding: utf-8
lib = File.expand_path "../lib", __FILE__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require "predicator/version"

Gem::Specification.new do |spec|
  spec.name          = "predicator"
  spec.version       = Predicator::VERSION
  spec.authors       = ["JohnnyT"]
  spec.email         = ["ubergeek3141@gmail.com"]

  spec.summary       = %q{A secure, non-evaling condition (boolean predicate) engine for end users}
  spec.homepage      = "https://github.com/riddler/predicator/tree/master/impl/rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin|test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename f }
  spec.require_paths = ["lib"]

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["changelog_uri"]     = "https://github.com/riddler/predicator/blob/master/impl/rb/HISTORY.md"
  spec.metadata["source_code_uri"]   = "https://github.com/riddler/predicator/tree/master/impl/rb"
  spec.metadata["bug_tracker_uri"]   = "https://github.com/riddler/predicator/issues"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "minitest", "= 5.4.2"
  spec.add_development_dependency "minitest-focus"
  spec.add_development_dependency "oedipus_lex"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "racc"
  spec.add_development_dependency "rake"
end
