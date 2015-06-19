module Blogit
  class Configuration
    
    include ActiveSupport::Configurable
    
    # Default values for active_state
    ACTIVE_STATES = [:published]

    # Default values for hidden_state
    HIDDEN_STATES = [:draft, :archive]    
    
    # When using redcarpet as content parser, pass these options as defaults.
    REDCARPET_OPTIONS = {
      hard_wrap: true,
      filter_html: true,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      gh_blockcode: true,
    }
    
    # What kind of comments do you want to add to your blog ? 
    # Valid options include :active_record, :disqus or :no
    #
    # Defaults to :active_record
    config_accessor(:include_comments) { :active_record }
    
    # When using disqus comments, what is the shortname of your forum ?
    #
    # Defaults to ""
    config_accessor(:disqus_shortname, instance_writer: false) { "" }
    
    # Should there be a share bar on every post ?
    #
    # Defaults to true
    config_accessor(:include_share_bar) { false }
    
    # Twitter username used in the share bar
    #
    # Defaults to ""
    config_accessor(:twitter_username, instance_writer: false) { "" }
    
    # The name of the controller method we'll call to return the current blogger.
    #
    # Defaults to :current_user
    config_accessor(:current_blogger_method) { :current_user }
    
    # What method do we call on blogger to return their display name?
    #
    # Defaults to :username
    config_accessor(:blogger_display_name_method) { :username }
    
    # Which DateTime::FORMATS format do we use to display
    # blog and comment publish time
    #
    # Defaults to :short
    config_accessor(:datetime_format) { :short }
    
    # Number of posts to show per page
    # @see https://github.com/amatsuda/kaminari
    # @see Blogit::Post
    config_accessor(:posts_per_page) { 5 }
    
    # If set to true, the comments form will POST and DELETE to the comments
    # controller using AJAX calls.
    #
    # Defaults to true
    config_accessor(:ajax_comments)  { true }
    
    # The default format for parsing the blog content.
    #
    # Defaults to :markdown
    config_accessor(:default_parser) { :markdown }
    

    # Should text within "```" or "`" be highlighted as code?
    # Defaults to true
    # @note - At the moment this only works when default_parser is :markdown
    config_accessor(:highlight_code_syntax) { true }
    
    # When using redcarpet as content parser, pass these options as defaults
    #
    # Defaults to REDCARPET_OPTIONS
    config_accessor(:redcarpet_options) { REDCARPET_OPTIONS }
    
    # List of states that will be visible to the public
    #
    # Defaults to ACTIVE_STATES
    config_accessor(:active_states) { ACTIVE_STATES }
    
    # List of states that will hide the posts from the public.
    #
    # Defaults to HIDDEN_STATES
    config_accessor(:hidden_states) { HIDDEN_STATES }
    
    # The title of the RSS feed for the blog posts
    #
    # Defaults to "[Application Name] Blog Posts"
    config_accessor(:rss_feed_title, instance_reader: false)
    
    # The description of the RSS feed for the blog posts
    # Defaults to "[Application Name] Blog Posts"
    config_accessor(:rss_feed_description, instance_reader: false)
    
    # The layout to be used by the posts controller
    #
    # Defaults to nil
    config_accessor :layout

    # Should show a description of the blog post on the index
    # and RSS feed.
    #
    # Defaults to true
    config_accessor(:show_post_description) { true }
    
    
    def default_parser_class
      "Blogit::Parsers::#{default_parser.to_s.classify}Parser".constantize
    end

    # If the user has defined a disqus shortname but hasn't set include_comments to
    # disqus, print a warning to the console.
    def disqus_shortname=(shortname)
      return if shortname.blank?
      unless include_comments == :disqus
        blogit_warn "You've set config.disqus_shortname in your blogit config file but \
         config.include_comments is not set to :disqus"
      end
      @disqus_shortname = shortname
    end

    # If the user has defined a disqus shortname but hasn't set include_comments to
    # disqus, print a warning to the console.
    def twitter_username=(username)
      unless include_share_bar
        blogit_warn "You've set config.twitter_username in your blogit config file but \
          config.include_share_bar is set to false"
      end
      @twitter_username = username
    end
    
    def rss_feed_title
      @rss_feed_title ||= "#{rails_app_name} Blog Posts"
    end
    
    def rss_feed_description
      @rss_feed_description ||= "Latest from #{rails_app_name}"
    end

    
    
    private


    def rails_app_name
      Rails.application.engine_name.titleize
    end


    def blogit_warn(message)
      warn "[Blogit]: #{message}"
    end

  end
  
end