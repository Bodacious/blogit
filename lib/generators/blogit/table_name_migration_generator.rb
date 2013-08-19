module Blogit
  module Generators
    class TableNameMigrationGenerator < Rails::Generators::Base
      
      source_root File.expand_path('../../templates', __FILE__)

      desc "Creates a Blogit initializer in your application's config/initializers dir"

      def copy_migration_file
        template "rename_blogit_tables.rb", "db/migrate/#{Time.now.to_s(:number)}_rename_blogit_tables.rb"
      end

    end
  end
end