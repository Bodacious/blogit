require "simplecov"
SimpleCov.start

require "rspec"
require "rspec/collection_matchers"
require "pry"
require "timecop"

RSpec.configure do |config|
  config.mock_with :mocha
  config.example_status_persistence_file_path = "./spec/examples"
end
