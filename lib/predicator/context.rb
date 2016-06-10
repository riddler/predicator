require "ostruct"

module Predicator
  class Context
    attr_reader :bindings

    def initialize attrs={}
      @bindings = {}
      attrs.each{ |key, val| bind key, val }
    end

    def bind name, obj
      if obj.kind_of? Hash
        obj = OpenStruct.new obj
      end
      bindings[name.to_s] = obj
    end
    alias :[]= :bind

    def node_for input
      value = value_for input
      node_class = Predicator::Nodes::BaseNode.class_for value
      node_class.new value
    end

    def value_for input
      if input.kind_of? Predicator::Variable
        input.value_in self
      else
        input
      end
    end
    alias :[] :value_for

    def respond_to? method
      bindings.key?(method.to_s) || super
    end

    def method_missing method, *args, &block
      found_binding = bindings.fetch method.to_s, nil
      if found_binding.nil?
        super
      else
        found_binding
      end
    end

    def eval string
      string.gsub(/{{([^}]+)}}/) do |match|
        name, attribute = $1.strip.split "."
        variable = Predicator::Variable.new name, attribute
        value_for variable
      end
    end

    def to_hash
      hsh = {}
      bindings.each do |key, value|
        hsh[key] = hash_value_for value
      end
      hsh
    end

    private

    def hash_value_for value
      if value.kind_of? OpenStruct
        value.to_h
      else
        value.to_hash
      end
    end
  end
end
