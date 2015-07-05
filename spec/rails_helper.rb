require 'spec_helper'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] = 'test'
ENV["DB"] ||= "sqlite"

require File.expand_path('../dummy/config/environment', __FILE__)

require 'rspec/rails'

require 'factory_girl'
require 'factories'

require 'support/authentication'
require 'support/helpers/css_matchers'

include Blogit

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
end

