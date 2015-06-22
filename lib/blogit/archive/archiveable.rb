module Blogit
  module Archive
    
    # This class is for documentation only, to define the Archiveable type
    class Archiveable
      
      # Archiveables must respond to :published_at and return a DateTime object.
      attr_accessor :published_at
        
      # Do not use this.
      #
      # Raises an exception.
      def initialize
        raise "Can't initialize an Archiveable. Class is for documentation only."
      end
      
    end
    
  end
end