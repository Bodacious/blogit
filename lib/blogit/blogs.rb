module Blogit
  module Blogs
    
    extend ActiveSupport::Concern
    
    module ClassMethods
      
      # When called within a model (usually User) this creates
      # a has-many assosciation between the model and {Post}
      def blogs
        @blogs = true
        has_many :blog_posts, :as => "blogger", :class_name => "Blogit::Post"
      end
      
      # Has this model been registered as a blogging model?
      #
      # Returns true or false
      def blogs?
        @blogs == true
      end
            
    end
    
  end
end