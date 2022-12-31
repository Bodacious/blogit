$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "blogit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blogit"
  s.version     = Blogit::VERSION
  s.authors     = ["bodacious"]
  s.email       = ["bodacious@gavinmorrice.com"]
  s.homepage    = "https://bodacious.github.com/blogit"
  s.summary     = "A mountable Rails blog for Rails applications"
  s.description = "Add a blog to your Rails application in minutes with this mountable"\
                    " Rails Engine"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency "acts-as-taggable-on", ">= 3.5.0"
  s.add_runtime_dependency "albino", ">=1.3.3"
  s.add_runtime_dependency "jquery-rails"
  s.add_runtime_dependency "kaminari"
  s.add_runtime_dependency "rails", "< 8", ">= 5.0.0"
  s.add_runtime_dependency "redcarpet"
  s.add_runtime_dependency "RedCloth", ">=4.2.9"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "thor"
  s.add_development_dependency "yard"
  s.add_development_dependency "yard-tomdoc"
  # Debugging
  s.add_development_dependency "pry"

  # Databases
  s.add_development_dependency "mysql2"
  s.add_development_dependency "pg"
  s.add_development_dependency "sqlite3"

  # Testing
  s.add_development_dependency "codeclimate-test-reporter"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "spring", ">=1.3.6"
  s.add_development_dependency "spring-commands-rspec"
  s.add_development_dependency "wwtd"

  s.add_development_dependency "autoprefixer-rails"
  s.add_development_dependency "factory_bot"
  s.add_development_dependency "growl"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rails-controller-testing"
  s.add_development_dependency "rb-fsevent", "~> 0.9.1" # OS X
  s.add_development_dependency "rspec-collection_matchers"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-performance"
  s.add_development_dependency "rubocop-rails"
  s.add_development_dependency "rubocop-rake"
  s.add_development_dependency "rubocop-rspec"
  s.add_development_dependency "sass"
  s.add_development_dependency "timecop"
end
