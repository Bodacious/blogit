$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blog"
  s.version     = Blog::VERSION
  s.authors     = ["Bodacious<Gavin Morrice>"]
  s.email       = ["gavin@gavinmorrice.com"]
  s.homepage    = "http://bodacious.github.com/blog/"
  s.summary     = "A mountable Rails blog for Rails 3.1 + applications"
  s.description = "Add a blog to your Rails application in minutes with this mountable Rails Engine"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
