module Blogit
  module Blogs

    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      
      # When called within a model (usually User) this creates
      # a has-many assosciation between the model and Blogit::Post
      def blogs
        @blogs = true
        has_many :blog_posts, :as => "blogger", :class_name => "Blogit::Post"
      end
      
      def blogs?
        @blogs == true
      end
            
    end
    
  end
end