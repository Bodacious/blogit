module Blogit
  module Archive
    class Month
  
      attr_accessor :month_name, :archiveables
  
      def initialize(month_name, archiveables)
        @month_name = month_name
        @archiveables = archiveables
      end
  
      def to_s
        month_name
      end
  
      def to_partial_path
        self.class.name.underscore
      end

    end
  end  
end