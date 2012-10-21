require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require

require "blogit"
require "jquery-rails" # this should be auto-included with the Bundler.require :default, Rails.env, but it's not happening

module Dummy
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'


    # Enable the asset pipeline
    config.assets.enabled = true
  end
end

