module Blogit
  class Engine < Rails::Engine
    isolate_namespace Blogit
    
    config.to_prepare do

      if defined?(::ActiveRecord::Base)
        ::ActiveRecord::Base.send(:include, Blogit::Blogs)
        ::ActiveRecord::Base.send(:include, Validators)
      end
      
    end
  end
end
