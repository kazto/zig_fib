# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rake/extensiontask"

task build: :compile

Rake::ExtensionTask.new("zig_fib") do |ext|
  ext.lib_dir = "lib/zig_fib"
end

task default: %i[clobber compile spec]
