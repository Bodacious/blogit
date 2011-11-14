module Blogit
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
    
    # Number of posts to show per page
    # @see https://github.com/amatsuda/kaminari
    # @see Blogit::Post
    attr_accessor :posts_per_page
    
    
    # The name of the before filter we'll call to authenticate the current user.
    # Defaults to :login_required
    attr_accessor :authentication_method
    
    # If set to true, only the user who authored the post may, edit or destroy.
    # Defaults to false
    # @note This has not been properly implemented yet
    attr_accessor :author_edits_only
    
    # If set to true, the comments form will POST and DELETE to the comments 
    # controller using AJAX calls.
    # Defaults to true
    attr_accessor :ajax_comments
    
    # If set to true, the create, edit, update and destroy actions
    # will be included. If set to false, you'll have to set these 
    # yourself elsewhere in the app
    attr_accessor :include_admin_actions
    
    # The default format for parsing the blog content.
    # Defaults to :markdown
    attr_accessor :default_parser
      
    # When using redcarpet as content parser, pass these options as defaults
    # Defaults to REDCARPET_OPTIONS
    attr_accessor :redcarpet_options  
    
    REDCARPET_OPTIONS = [:hard_wrap, :filter_html, :autolink, 
        :no_intraemphasis, :fenced_code, :gh_blockcode]
    
    def initialize
      @include_comments            = true
      @current_blogger_method      = :current_user
      @blogger_display_name_method = :username
      @datetime_format             = :short
      @posts_per_page              = 5
      @authentication_method       = :login_required
      @author_edits_only           = false
      @ajax_comments               = true
      @include_admin_actions       = true
      @default_parser           = :markdown
      @redcarpet_options           = REDCARPET_OPTIONS
    end
    
    def default_parser_class
      "Blogit::Parsers::#{@default_parser.to_s.classify}Parser".constantize
    end
    
  end
end