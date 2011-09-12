module Blog
  class Configuration
    
    # Should we include comments for blog posts?
    attr_accessor :include_comments

    # The name of the controller method we'll call to return the current blogger.
    attr_accessor :current_blogger_method
    
    # what method do we call on blogger to return their display name?
    # Defaults to :username
    attr_accessor :blogger_display_name_method
    
    # Which DateTime::FORMATS format do we use to display 
    # blog and comment publish time
    # Defaults to :short
    attr_accessor :datetime_format
    
    # No. of posts to show per page
    # 
    # @see https://github.com/amatsuda/kaminari
    # @see Blog::Post
    attr_accessor :posts_per_page
    
    
    # The name of the before filter we'll call to authenticate the current user.
    # Defaults to :login_required
    attr_accessor :authentication_method
    
    def initialize
      @include_comments            = true
      @current_blogger_method      = :current_user
      @blogger_display_name_method = :username
      @datetime_format             = :short
      @posts_per_page              = 5
      @authentication_method       = :login_required
    end
    
  end
end