module Blogit
  module Archive
    
    # Used internally by {List} when creating a new archive list.
    class Month
  
      attr_reader :month_name
      
      alias_method :to_s, :month_name
      
      attr_reader :archiveables
      
      # Creates a new {Month} object
      #
      # month_name   - The name of the month for this collection of archiveables
      # archiveables - A collection of _archiveable_ objects
      #
      def initialize(month_name, archiveables)
        @month_name   = month_name
        @archiveables = archiveables
      end
  
  
      # The name of the partial to load for a {Month} object
      #
      # Returns a String
      def to_partial_path
        self.class.name.underscore
      end

    end
    
  end
end