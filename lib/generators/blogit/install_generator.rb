module Blogit
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      source_root File.expand_path('../../templates', __FILE__)

      desc "Creates a Blogit initializer in your application's config/initializers dir"

      def copy_initializer
        template "blogit.rb", "config/initializers/blogit.rb"
      end

    end
  end
end