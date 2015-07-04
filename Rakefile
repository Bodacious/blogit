#!/usr/bin/env rake
require "rubygems"

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core'
require 'rspec/core/rake_task'

require 'sass'; puts Sass::VERSION
load "appraisal/task.rb"


require 'wwtd/tasks'
task :default => "wwtd:local" # run all gemfiles with local ruby

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks


Dir[File.join(File.dirname(__FILE__), 'lib/tasks/**/*.rake')].each {|f| load f }

Dir[File.join(File.dirname(__FILE__), 'spec/dummy/lib/tasks/**/*.rake')].each {|f| load f}


desc "Run all specs in spec directory (excluding plugin specs)"

RSpec::Core::RakeTask.new(:spec => 'app:db:test:prepare')