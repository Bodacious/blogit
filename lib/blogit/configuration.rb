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

    # If set to true, only the user who authored the post may, edit or destroy.
    # Defaults to false
    attr_accessor :author_edits_only

    # If set to true, the comments form will POST and DELETE to the comments
    # controller using AJAX calls.
    # Defaults to true
    attr_accessor :ajax_comments

    # If set to true, the create, edit, update and destroy actions
    # will be included. If set to false, you'll have to set these
    # yourself elsewhere in the app
    attr_accessor :include_admin_actions

    # If set to true, links for new posts, editing posts and deleting comments
    # will be available. If set to false, you'll have to set these
    # yourself in the templates.
    attr_accessor :include_admin_links

    # The default format for parsing the blog content.
    # Defaults to :markdown
    attr_accessor :default_parser

    # When using redcarpet as content parser, pass these options as defaults
    # Defaults to REDCARPET_OPTIONS
    attr_accessor :redcarpet_options

    # Should the controllers cache the blog pages as HTML?
    # Defaults to false
    attr_accessor :cache_pages

    # The title of the RSS feed for the blog posts
    # Defaults to "[Application Name] Blog Posts"
    attr_accessor :rss_feed_title

    # The description of the RSS feed for the blog posts
    # Defaults to "[Application Name] Blog Posts"
    attr_accessor :rss_feed_description

    # Should the routes of the main app be accessible without
    # the "main_app." prefix ?
    attr_accessor :inline_main_app_named_routes

    # Should blogit ping search engines with your sitemap
    # when posts are created, updated or destroyed?
    # Defaults to false
    attr_accessor :ping_search_engines
    
    # When using redcarpet as content parser, pass these options as defaults.
    REDCARPET_OPTIONS = {
      hard_wrap: true,
      filter_html: true,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      gh_blockcode: true,
    }

    def initialize
      @include_comments            = :active_record
      @disqus_shortname            = ""
      @include_share_bar           = false
      @twitter_username            = ""
      @current_blogger_method      = :current_user
      @blogger_display_name_method = :username
      @datetime_format             = :short
      @posts_per_page              = 5
      @authentication_method       = :login_required
      @author_edits_only           = false
      @ajax_comments               = true
      @include_admin_actions       = true
      @include_admin_links         = true
      @cache_pages                 = false
      @default_parser              = :markdown
      @highlight_code_syntax       = true
      @rss_feed_title              = "#{Rails.application.engine_name.titleize} Blog Posts"
      @rss_feed_description        = "#{Rails.application.engine_name.titleize} Blog Posts"
      @ping_search_engines         = false
      @redcarpet_options           = REDCARPET_OPTIONS
    end

    def default_parser_class
      "Blogit::Parsers::#{@default_parser.to_s.classify}Parser".constantize
    end

    # If the user has defined a disqus shortname but hasn't set include_comments to
    # disqus, print a warning to the console.
    def disqus_shortname=(shortname)
      if @include_comments && @include_comments != :disqus
        blogit_warn "You've set config.disqus_shortname in your blogit config file but config.include_comments is not set to :disqus"
      end
      @disqus_shortname = shortname
    end

    # If the user has defined a disqus shortname but hasn't set include_comments to
    # disqus, print a warning to the console.
    def twitter_username=(username)
      if not @include_share_bar
        blogit_warn "You've set config.twitter_username in your blogit config file but config.include_share_bar is set to false"
      end
      @twitter_username = username
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
