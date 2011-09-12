
module Blog
  class Post < ActiveRecord::Base

    acts_as_taggable    
    
    paginates_per Blog.configuration.posts_per_page
    
    # ===============
    # = Validations =
    # ===============

    validates :title, presence: true, length: { minimum: 10, maximum: 66 }
    validates :body,  presence: true, length: { minimum: 10 }
    validates :blogger_id, presence: true
    
    # =================
    # = Assosciations =
    # =================    

    belongs_to :blogger, :polymorphic => true
    
    if Blog.configuration.include_comments 
      has_many :comments, :class_name => "Blog::Comment"
    end
    
    # ==========
    # = Scopes =
    # ==========

    # Returns the blog posts paginated for the index page
    # @scope class
    scope :for_index, lambda { |page = 1| order("updated_at DESC").page(page) }
    
    # ====================
    # = Instance Methods =
    # ====================
    
    def to_param
      "#{id}-#{title.parameterize}"
    end
    
    # If there's a current blogger and the display name method is set, returns the blogger's display name
    # Otherwise, returns an empty string
    def blogger_display_name
      raise ConfigurationError, "#{self.blogger.class}##{Blog.configuration.blogger_display_name_method} is not defined" if self.blogger and !self.blogger.respond_to?(Blog.configuration.blogger_display_name_method)
      self.blogger.send Blog.configuration.blogger_display_name_method
    end
  
  end
end