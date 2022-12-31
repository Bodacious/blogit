module Blogit
  class Engine < Rails::Engine
    isolate_namespace Blogit

    initializer "blogit.extend_active_record" do
      if defined?(::ActiveRecord::Base)
        ::ActiveRecord::Base.include Blogit::Blogs
        ::ActiveRecord::Base.include Validators
      end
    end
  end
end
