if RUBY_ENGINE == "maglev"
  class String
    alias_method :byteslice, :slice
  end
  require "rubygems"
end

require "parslet"
require "parslet/convenience"

require "predicator/version"

require "predicator/context"
require "predicator/parser"
require "predicator/transform"
require "predicator/variable"

require "predicator/predicates/and"
require "predicator/predicates/equals"
require "predicator/predicates/false"
require "predicator/predicates/not"
require "predicator/predicates/or"
require "predicator/predicates/true"

module Predicator
  extend self

  def parse string
    ast = Parser.new.parse_with_debug string
    Transform.new.apply ast
  end
end
