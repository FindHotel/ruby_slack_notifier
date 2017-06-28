require "bundler/gem_tasks"

task default: :spec

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec, :tag) do |t, task_args|
    t.rspec_opts = ['--format documentation']
    t.rspec_opts << '--color'
    t.rspec_opts << '--order rand:42'
    t.rspec_opts << "--tag #{task_args[:tag]}" if task_args[:tag]
  end
rescue LoadError
  # no rspec available
  raise 'Yo, no RSpec?'
end
