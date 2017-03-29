module Blogit
  class Engine < Rails::Engine
    isolate_namespace Blogit
    
    initializer "blogit.extend_active_record" do

      if defined?(::ActiveRecord::Base)
        ::ActiveRecord::Base.send(:include, Blogit::Blogs)
        ::ActiveRecord::Base.send(:include, Validators)
      end

    end

    initializer 'blogit.active_record' do
      ActiveSupport.on_load :active_record do
        unless ActiveRecord::Migration.respond_to? :[]
          require "blogit/compatibility"
          ActiveRecord::Migration.extend Blogit::Compatibility::Migration
        end
      end
    end
  end
end
