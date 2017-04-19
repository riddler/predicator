require "rubygems"
#require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new :test do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
  t.warning = false
end

rule ".rb" => ".y" do |t|
  sh "racc -l -o #{t.name} #{t.source}"
end

desc "Compile and generate the parser"
task :compile => "lib/predicator/parser.rb"

task :test => :compile

task :default => :test
