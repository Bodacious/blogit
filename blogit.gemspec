$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blogit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blogit"
  s.version     = Blogit::VERSION
  s.authors     = ["Bodacious"]
  s.email       = ["bodacious@katanacode.com"]
  s.homepage    = "http://blogit.katanacode.com/"
  s.summary     = "A mountable Rails blog for Rails applications"
  s.description = "Add a blog to your Rails application in minutes with this mountable"\
                    " Rails Engine"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency "rails", "< 6", ">= 4.0.13"
  s.add_runtime_dependency "RedCloth", ">=4.2.9"
  s.add_runtime_dependency 'redcarpet', ">=2.0.1"
  s.add_runtime_dependency 'nokogiri', '>= 1.5.0'
  # TODO (breaking change): should be removed and added manually to project using it
  s.add_runtime_dependency "albino", ">=1.3.3"
  s.add_runtime_dependency "kaminari"
  s.add_runtime_dependency "jquery-rails"
  s.add_runtime_dependency "acts-as-taggable-on", ">= 3.5.0"


  s.add_development_dependency "appraisal"
  s.add_development_dependency 'thor'
  s.add_development_dependency "yard"
  s.add_development_dependency "yard-tomdoc"
  # Debugging
  s.add_development_dependency "pry"

  # Databases
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "pg"

  # Testing
  s.add_development_dependency "codeclimate-test-reporter"
  s.add_development_dependency "spring", ">=1.3.6"
  s.add_development_dependency 'spring-commands-rspec'
  s.add_development_dependency "wwtd"

  s.add_development_dependency "autoprefixer-rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec-collection_matchers"
  s.add_development_dependency "rb-fsevent",  "~> 0.9.1" # OS X
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "growl"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "mocha"
  s.add_development_dependency "sass"
  s.add_development_dependency "timecop"
end
