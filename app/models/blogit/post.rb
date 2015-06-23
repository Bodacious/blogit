module Blogit
  class Post < ActiveRecord::Base
    
    require "kaminari"
    require "acts-as-taggable-on"

    acts_as_taggable

    self.paginates_per(Blogit.configuration.posts_per_page)

    # ===============
    # = Validations =
    # ===============

    validates :title, presence: true, length: { minimum: 10, maximum: 66 }

    validates :body,  presence: true, length: { minimum: 10 }
    
    validates :description, presence: Blogit.configuration.show_post_description

    validates :blogger_id, presence: true

    validates :state, presence: true

    # ================
    # = Associations =
    # ================

    ##
    # The blogger (User, Admin, etc.) who wrote this Post
    #
    # Returns a Blogger (polymorphic type)
    belongs_to :blogger, :polymorphic => true

    ##
    # The {Comment Comments} written on this Post
    #
    # Returns an ActiveRecord::Relation instance
    has_many :comments, :class_name => "Blogit::Comment"

    # ==========
    # = Scopes =
    # ==========

    scope :for_index, lambda { |page_no = 1| 
      active.order("created_at DESC").page(page_no) }
      
    scope :active, lambda { where(state:  Blogit.configuration.active_states ) }


    # The posts to be displayed for RSS and XML feeds/sitemaps
    #
    # Returns an ActiveRecord::Relation
    def self.for_feed
      active.order('created_at DESC')
    end
    
    # Finds an active post with given id
    #
    # id - The id of the Post to find
    #
    # Returns a Blogit::Post
    # Raises ActiveRecord::NoMethodError if no Blogit::Post could be found
    def self.active_with_id(id)
      active.find(id)
    end
    
    # ====================
    # = Instance Methods =
    # ====================

    # TODO: Get published at working properly!
    def published_at
      created_at
    end
    
    def to_param
      "#{id}-#{title.parameterize}"
    end
    
    # The content of the Post to be shown in the RSS feed.
    #
    # Returns description when Blogit.configuration.show_post_description is true
    # Returns body when Blogit.configuration.show_post_description is false
    def short_body
      if Blogit.configuration.show_post_description
        description
      else
        body
      end
    end
    
    def comments
      check_comments_config
      super()
    end
    
    def comments=(value)
      check_comments_config
      super(value)
    end
    

    # The blogger who wrote this {Post Post's} display name
    #
    # Returns the blogger's display name as a String if it's set.
    # Returns an empty String if blogger is not present.
    # Raises a ConfigurationError if the method called is not defined on {#blogger}
    def blogger_display_name
      return "" if blogger.blank?
      if blogger.respond_to?(Blogit.configuration.blogger_display_name_method)
        blogger.send(Blogit.configuration.blogger_display_name_method)
      else
        method_name = Blogit.configuration.blogger_display_name_method
        raise ConfigurationError, "#{blogger.class}##{method_name} is not defined"
      end
    end

    # If there's a blogger and that blogger responds to :twitter_username, returns that.
    # Otherwise, returns nil
    def blogger_twitter_username
      if blogger and blogger.respond_to?(:twitter_username)
        blogger.twitter_username
      end
    end
    

    private


    def check_comments_config
      unless Blogit.configuration.include_comments == :active_record
        raise RuntimeError, 
          "Posts only allow active record comments (check blogit configuration)"
      end
    end
    
  end
end