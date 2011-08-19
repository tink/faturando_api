require "bundler/gem_tasks"
require 'rake'
require 'rspec/core/rake_task'

desc 'Run the spec suite'
RSpec::Core::RakeTask.new('spec') {|t|
  t.rspec_opts = ['--colour', '--format documentation']
}

task :default => :spec
