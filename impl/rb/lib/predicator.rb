if RUBY_ENGINE == "maglev"
  class String
    alias_method :byteslice, :slice
  end
  require "rubygems"
end

require "parslet"
require "parslet/convenience"

require "predicator/version"

require "predicator/parser"
require "predicator/transform"
require "predicator/context"

require "predicator/predicates/not"
require "predicator/predicates/and"
require "predicator/predicates/or"

module Predicator
end
