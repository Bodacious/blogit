require 'yaml'
load "lib/tasks/blogit/css.rake"

namespace :blogit do
  
  desc "Add a bunch of mock blog posts to the database for dev"
  task :seed => :environment do
    if Rails.env.production?
      warn "Can't seed your production database bro, too risky!"
    else
      load_all_models
      seed_blog_content.each do |blog_post_atts|
        state = Blogit.configuration.active_states.first
        begin
          blogger.first.blog_posts.create!(blog_post_atts.merge(state: state))
        rescue NoMethodError
          warn "Couldn't find a blogger model record :("
        end
      end      
    end
  end
  
  
  private
  
  
  def seed_blog_content
    YAML.load(File.read(File.join("lib/tasks/seed_blog_posts.yml")))
  end
  
  
  def load_all_models
    Dir[Rails.root.join("app/models/**/*.rb")].each { |file| load file }
  end
  
  # The fellow who's going to write these posts...
  def blogger
    ActiveRecord::Base.subclasses.detect(&:blogs?) ||
      warn("Can't seed your database, couldn't find a model that #blogs?")
  end
  
end
