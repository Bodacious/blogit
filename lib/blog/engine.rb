module Blog
  class Engine < Rails::Engine
    isolate_namespace Blog
    
    config.to_prepare do

      if defined?(::ActiveRecord::Base)
        ::ActiveRecord::Base.send(:include, Blog::Blogs)
        ::ActiveRecord::Base.send(:include, Validators)
      end
      
    end
  end
end
