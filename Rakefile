require "rubygems"
#require "bundler/gem_tasks"
require "rake/testtask"
require "oedipus_lex"

Rake.application.rake_require "oedipus_lex"

Rake::TestTask.new :test do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/test_*.rb"]
  t.warning = false
end

desc "Generate the lexer"
task lexer: "lib/predicator/lexer.rex.rb"

desc "Compile and generate the parser"
task parser: :lexer do
  sh "racc -l -o lib/predicator/parser.rb lib/predicator/parser.y"
end

task test: :parser

task default: :test
