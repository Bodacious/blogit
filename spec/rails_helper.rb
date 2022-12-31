require "spec_helper"

ENV["RAILS_ENV"] = "test"
ENV["DB"] ||= "sqlite"

require File.expand_path("dummy/config/environment", __dir__)
require "rspec/rails"

require "rails-controller-testing"
Rails::Controller::Testing.install

require "factory_bot"
require "factories"

require "support/authentication"
require "support/helpers/css_matchers"

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FactoryBot::Syntax::Methods
end
