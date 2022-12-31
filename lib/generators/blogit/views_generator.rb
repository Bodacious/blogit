module Blogit
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      desc "Copies Blogit views to your application."

      include Thor::Actions

      source_root File.expand_path("../../../app/views", __dir__)

      # Copy all of the views from the blogit/app/views/blogit to
      # app/views/blogit
      def copy_views
        directory "blogit", "app/views/blogit"
      end
    end
  end
end
