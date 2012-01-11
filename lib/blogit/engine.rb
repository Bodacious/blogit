module Blogit
  class Engine < Rails::Engine
    isolate_namespace Blogit
    
    initializer "blogit.extend_active_record" do

      if defined?(::ActiveRecord::Base)
        ::ActiveRecord::Base.send(:include, Blogit::Blogs)
        ::ActiveRecord::Base.send(:include, Validators)
      end
      
    end
  end
end
