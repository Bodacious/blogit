#!/usr/bin/env rake
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "rubygems"
require 'bundler/setup'
require 'bundler/gem_tasks'
require "blogit/version"
require 'rspec/core'
require 'rspec/core/rake_task'

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

load 'rails/tasks/engine.rake'

Dir[File.join(File.dirname(__FILE__), 'lib/tasks/**/*.rake')].each { |f| import f }
Dir[File.join(File.dirname(__FILE__), 'spec/dummy/lib/tasks/**/*.rake')].
  each { |f| import f }

task :default => :spec
RSpec::Core::RakeTask.new(:spec)