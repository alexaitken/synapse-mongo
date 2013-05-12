require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'lib' << 'test'
  t.test_files = FileList.new 'test/**/*test.rb'
end
