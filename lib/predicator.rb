require "predicator/context"
require "predicator/evaluator"
require "predicator/parser"
require "predicator/memory_repo"

module Predicator
  def self.parse source
    Predicator::Parser.new.parse source
  end

  def self.compile source
    ast = Predicator.parse source
    ast.to_instructions
  end

  # In Rails - assuming we have:
  #
  # class ::Predicate < ActiveRecord::Base
  # end
  #
  # Then configure:
  #
  # Predicator.repo = ::Predicate
  def self.repo
    @repo ||= MemoryRepo.new
  end

  def self.repo= repo
    @repo = repo
  end

  def self.find name
    repo.find_by_name name
  end

  def self.create attributes={}
    repo.create attributes
  end
end
