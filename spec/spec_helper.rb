require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'rspec'
require "rspec/collection_matchers"
require 'pry'
require 'timecop'

RSpec.configure do |config|
  config.mock_with :mocha
end

