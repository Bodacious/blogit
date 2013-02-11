module Blogit
  class Post < ActiveRecord::Base

    require "acts-as-taggable-on"
    require "kaminari"

    acts_as_taggable

    self.table_name = "blog_posts"

    self.paginates_per Blogit.configuration.posts_per_page

    # ==============
    # = Attributes =
    # ==============
    attr_accessible :title, :body, :tag_list, :blogger_type, :blogger_id

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

    has_many :comments, :class_name => "Blogit::Comment"

    def comments
      check_comments_config
      super()
    end
    def comments=(value)
      check_comments_config
      super(value)
    end

    # ==========
    # = Scopes =
    # ==========

    # Returns the blog posts paginated for the index page
    # @scope class
    scope :for_index, lambda { |page_no = 1| order("created_at DESC").page(page_no) }

    # ====================
    # = Instance Methods =
    # ====================

    def to_param
      "#{id}-#{title.parameterize}"
    end

    # If there's a current blogger and the display name method is set, returns the blogger's display name
    # Otherwise, returns an empty string
    def blogger_display_name
      if self.blogger and !self.blogger.respond_to?(Blogit.configuration.blogger_display_name_method)
        raise ConfigurationError,
        "#{self.blogger.class}##{Blogit.configuration.blogger_display_name_method} is not defined"
      elsif self.blogger.nil?
        ""
      else
        self.blogger.send Blogit.configuration.blogger_display_name_method
      end
    end

    private

    def check_comments_config
      raise RuntimeError.new("Posts only allow active record comments (check blogit configuration)") unless Blogit.configuration.include_comments == :active_record
    end
  end
end
