source "http://rubygems.org"

# Declare your gem's dependencies in blogit.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
when "master"
  {github: "rails/rails"}
when "default"
  ">= 4.0.3"
else
  "~> #{rails_version}"
end

gem "rails", rails

# If we're using Rails 3 - include the 
# strong_parameters gem. Otherwise, it should be inluded as part of Rails 4
if rails_version[0] == '3'
  gem 'strong_parameters'
end