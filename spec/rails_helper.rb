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

module KeywordArgumentsShim
  [ :head, :get, :post, :put, :patch, :delete ].each do |m|
    define_method m do |url, *args|
      if process_with_kwargs?
        super url, *args
      else
        args = args[0]
        super url, args[:params], args[:session], args[:flash]
      end
    end
  end

  def process_with_kwargs?
    Rails.gem_version >= Gem::Version.new('5.0')
  end
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include KeywordArgumentsShim
end
