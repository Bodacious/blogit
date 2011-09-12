source "http://rubygems.org"

gem 'acts-as-taggable-on'
gem "decent_exposure"
gem 'jquery-rails'
gem "redcarpet"
gem "kaminari"

group :test, :development do
  gem 'rails', '3.1.0'

  gem 'sqlite3'  
  gem "guard"
  gem "guard-rspec"

  if RUBY_PLATFORM =~ /darwin/i
    gem "rb-fsevent" 
    gem "growl"      
  end
  
  gem "factory_girl", "2.0.0.rc4"
  gem "mocha"
  gem "rspec"
  gem "rspec-rails"
end