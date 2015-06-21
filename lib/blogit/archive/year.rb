module Blogit
  module Archive
    class Year
  
      attr_accessor :year, :months
  
      def initialize(year, archiveables)
        @year   = year
        @months = create_months_from_archiveables(archiveables)
      end
  
      def to_s
        year
      end
      
      # The name of the partial to load for a {Year} object
      #
      # Returns a String
      def to_partial_path
        self.class.name.underscore
      end
      
      
      private
      
      
      def create_months_from_archiveables(archiveables)
        months_with_archiveables(archiveables).
          map { |month, archs| Month.new(month, archs) }
      end
      
      def months_with_archiveables(archiveables)
        archiveables.chunk { |a| 
          I18n.localize(a.published_at, format: :plain_month_only) 
        }
      end
  
    end
  end
end