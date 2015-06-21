module Blogit
  module Archive
    
    # Public: The main class to be accessed when creating a HTML post archive.
    class List
    
      attr_accessor :years, :archiveables
  
      # Create a new {List List} object
      #
      # archiveables - A collection of _archiveable_ objects. An archiveable is any
      #                object that responds to published_at.
      #
      def initialize(archiveables)
        @archiveables = archiveables
        ensure_archiveables_are_valid
        @years = create_years_from_archiveables
      end
      
      # The name of the partial to load for a {List List} object
      #
      # Returns a String
      def to_partial_path
        self.class.name.underscore
      end
  
  
      private
      
      
      def ensure_archiveables_are_valid
        return true unless archiveables.detect { |a| !a.respond_to?(:published_at) }
        raise Blogit::Archive::ArchiveError, 
          "Invalid archive object detected. Please make sure your archiveable objects \
           respond to :published_at."
      end
      
      def create_years_from_archiveables
        years_with_archiveables.map { |year, archs| Year.new(year, archs) }
      end
      
      def years_with_archiveables
        archiveables.chunk { |a| a.published_at.year }
      end
      
    end
  end
end