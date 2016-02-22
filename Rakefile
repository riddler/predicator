require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new :test do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

desc "Compile and generate the parser"
task :compile do
  sh "racc -E lib/predicator/parser.y -o lib/predicator/generated_parser.rb"
end
