# coding: utf-8
lib = File.expand_path "../lib", __FILE__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require "predicator/version"

Gem::Specification.new do |spec|
  spec.name          = "predicator"
  spec.version       = Predicator::VERSION
  spec.authors       = ["JohnnyT"]
  spec.email         = ["ubergeek3141@gmail.com"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "parslet"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "= 5.4.2"
end
