module Blogit
  module Archive
    class List
    
      attr_accessor :years, :archiveables
  
      def initialize(archiveables)
        @archiveables = archiveables
        ensure_archiveables_are_valid
        @years = create_years_from_archiveables
      end
  
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