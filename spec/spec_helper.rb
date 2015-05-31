require 'pry'

require 'rspec'
require "rspec/collection_matchers"
require 'pry'

RSpec.configure do |config|
  config.mock_with :mocha
end

