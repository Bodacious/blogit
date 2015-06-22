require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'rspec'
require "rspec/collection_matchers"
require 'pry'

RSpec.configure do |config|
  config.mock_with :mocha
end

