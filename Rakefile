require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test/lib"
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end

if RUBY_ENGINE == 'ruby'
  require 'rake/extensiontask'
  Rake::ExtensionTask.new("pathname")
else
  task :compile
end

task :default => [:compile, :test]
