require 'spec_helper'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment', __FILE__)

require 'rspec/rails'

require 'factory_girl'
require 'factories'

require 'support/authentication'

load "#{Rails.root}/db/schema.rb"

include Blogit

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

