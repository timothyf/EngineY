# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

require 'disguise/tasks'

test_dir = File.expand_path('test')

Rake::TestTask.new('api_tests') do |t|
  t.libs = [test_dir]
  t.pattern = 'test/api/*.rb'
  t.warning = false
end
