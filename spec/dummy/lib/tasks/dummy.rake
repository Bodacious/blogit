namespace :dummy do
  
  desc "Sets up the dummy application to the point just before blogit will be installed"
  task :setup do
    puts `spring rake app:acts_as_taggable_on_engine:install:migrations`
    puts `spring rake db:migrate`
    
  end
  
  desc "Cleans the dummy application so we can test the installation again"
  task :clean do
    remove_joined_file("db", "migrate", "*.acts_as_taggable_on_engine*.rb")
    remove_joined_file("db", "migrate", "*.blogit*.rb")    
    remove_joined_file("config", "initializers", "blogit.rb")
    remove_joined_file("db", "schema.rb")
  end
  
  
  private
  
  
  def remove_joined_file(*args)
    filepath = Rails.root.join(*args)
    Dir[filepath].each { |path| 
      FileUtils.rm(path)
      warn "Removed #{path}" 
    }    
  end
end