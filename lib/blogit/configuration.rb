module Blogit
  class Configuration

    # What kind of comments do you want to add to your blog ? (:active_record, :disqus or :no)
    attr_accessor :include_comments

    # When using disqus comments, what is the shortname of your forum ?
    attr_reader :disqus_shortname

    # Should there be a share bar on every post ?
    attr_accessor :include_share_bar

    # Twitter username used in the share bar
    attr_reader :twitter_username

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

    # Should text within "```" or "`" be highlighted as code?
    # Defaults to true
    # @note - At the moment this only works when default_parser
    #   is :markdown
    attr_accessor :highlight_code_syntax

    # The name of the before filter we'll call to authenticate the current user.
    # Defaults to :login_required
    attr_accessor :authentication_method

    # If set to true, the comments form will POST and DELETE to the comments
    # controller using AJAX calls.
    # Defaults to true
    attr_accessor :ajax_comments

    # The default format for parsing the blog content.
    # Defaults to :markdown
    attr_accessor :default_parser

    # When using redcarpet as content parser, pass these options as defaults
    # Defaults to REDCARPET_OPTIONS
    attr_accessor :redcarpet_options

    # The title of the RSS feed for the blog posts
    # Defaults to "[Application Name] Blog Posts"
    attr_accessor :rss_feed_title

    # The description of the RSS feed for the blog posts
    # Defaults to "[Application Name] Blog Posts"
    attr_accessor :rss_feed_description

    # The layout to be used by the posts controller
    # Defaults to nil
    attr_accessor :layout

    # list of states that will be visible to the public
    attr_accessor :active_states

    # list of states that will hide the posts from the public.
    attr_accessor :hidden_states

    # list of states for the Post state machine in order or lifecycle, aggregation of hidden_states and active_states
    #attr_accessor :post_states

    # When using redcarpet as content parser, pass these options as defaults.
    REDCARPET_OPTIONS = {
      hard_wrap: true,
      filter_html: true,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      gh_blockcode: true,
    }

    #default values for active_state
    ACTIVE_STATES = [:published]

    #default values for hidden_state
    HIDDEN_STATES = [:draft, :archive]    

    def initialize
      @include_comments            = :active_record
      @disqus_shortname            = ""
      @include_share_bar           = false
      @twitter_username            = ""
      @current_blogger_method      = :current_user
      @blogger_display_name_method = :username
      @datetime_format             = :short
      @posts_per_page              = 5
      @ajax_comments               = true
      @default_parser              = :markdown
      @highlight_code_syntax       = true
      @redcarpet_options           = REDCARPET_OPTIONS
      @active_states               = ACTIVE_STATES
      @hidden_states               = HIDDEN_STATES
    end

    def default_parser_class
      "Blogit::Parsers::#{default_parser.to_s.classify}Parser".constantize
    end

    # If the user has defined a disqus shortname but hasn't set include_comments to
    # disqus, print a warning to the console.
    def disqus_shortname=(shortname)
      if include_comments && include_comments != :disqus
        blogit_warn "You've set config.disqus_shortname in your blogit config file but config.include_comments is not set to :disqus"
      end
      @disqus_shortname = shortname
    end

    # If the user has defined a disqus shortname but hasn't set include_comments to
    # disqus, print a warning to the console.
    def twitter_username=(username)
      unless include_share_bar
        blogit_warn "You've set config.twitter_username in your blogit config file but config.include_share_bar is set to false"
      end
      @twitter_username = username
    end
    
    def rss_feed_title
      @rss_feed_title ||= "#{rails_app_name} Blog Posts"
    end
    
    def rss_feed_description
      @rss_feed_description ||= "Latest from #{rails_app_name}"
    end
    
    def rails_app_name
      Rails.application.engine_name.titleize
    end
    

    def rss_feed_language=(locale)
      blogit_warn "#{self.class}#rss_feed_language has been deprecated. You can remove this from your blogit.rb configuration file"
    end
    
    
    private


    def blogit_warn(message)
      warn "[Blogit]: #{message}"
    end

  end
  
end