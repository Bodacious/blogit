module Blogit

  # This class handles the global configuration options for Blogit.
  #  When you run `rails g blogit:install` this will add an initializer file to
  #  config/initializers/blogit.rb with all of the default configurations applied.
  #
  #  You can read about each of the individual configuration options below.
  class Configuration

    include ActiveSupport::Configurable

    # An Array containing the default states for {Blogit::Post Posts} that are considered
    #   "active". ("Active" {Post posts} are those that can be viewed by the public).
    ACTIVE_STATES = [:published]

    # An Array containing the default states for {Blogit::Post Posts} that are considered
    #   "hidden". ("Hidden" {Post posts} are those that may not be viewed by the public).
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

    ##
    # How do you want to handle comments for your blog?
    #   Valid options are :active_record, :disquss, or :no for none.
    #   (default: :active_record)
    config_accessor(:include_comments) { :active_record }

    ##
    # When using :disqus comments, what is the shortname of your forum?
    #  (default: nil)
    config_accessor(:disqus_shortname, instance_writer: false)

    ##
    # Load a javascript-based share bar on each blog post?. (default: true)
    config_accessor(:include_share_bar) { true }

    ##
    # Twitter username used in the share bar. (default: nil)
    config_accessor(:twitter_username)

    ##
    # The name of the controller method we'll call to return the current blogger.
    #   (default: :current_user)
    config_accessor(:current_blogger_method) { :current_user }

    ##
    # What method do we call on blogger to return their display name? (default: :username)
    config_accessor(:blogger_display_name_method) { :username }

    ##
    # Which DateTime::FORMATS format do we use to display blog and comment publish time
    #   (default: :short)
    config_accessor(:datetime_format) { :short }

    ##
    # Number of {Blogit::Post posts} to show per page. This is a configuration for {https://github.com/amatsuda/kaminari Kaminari} (default: 5)
    #
    # Returns an Integer
    config_accessor(:posts_per_page) { 5 }

    ##
    # If set to true, the comments form will POST and DELETE to the comments
    # controller using AJAX calls.
    #
    # Returns true or false
    config_accessor(:ajax_comments)  { true }

    ##
    # The default format for parsing the blog content.
    #
    # Defaults to :markdown
    config_accessor(:default_parser) { :markdown }

    ##
    # Should text within "```" or "`" be highlighted as code?
    # Defaults to true
    # @note - At the moment this only works when default_parser is :markdown
    config_accessor(:highlight_code_syntax) { true }

    ##
    # The renderer used for code highlighting
    # Defaults to :albino
    config_accessor(:syntax_highlighter) { :albino }

    ##
    # When using redcarpet as content parser, pass these options as defaults
    #
    # Defaults to {REDCARPET_OPTIONS}
    config_accessor(:redcarpet_options) { REDCARPET_OPTIONS }

    ##
    # List of states that will be visible to the public
    #
    # Defaults to ACTIVE_STATES
    config_accessor(:active_states) { ACTIVE_STATES }

    ##
    # List of states that will hide the posts from the public.
    #
    # Defaults to HIDDEN_STATES
    config_accessor(:hidden_states) { HIDDEN_STATES }

    ##
    # The title of the RSS feed for the blog posts
    #
    # Defaults to "[Application Name] Blog Posts"
    config_accessor(:rss_feed_title, instance_reader: false)

    ##
    # The description of the RSS feed for the blog posts
    # Defaults to "[Application Name] Blog Posts"
    config_accessor(:rss_feed_description, instance_reader: false)

    ##
    # The layout to be used by the posts controller
    #
    # Defaults to nil
    config_accessor :layout

    ##
    # Should show a description of the blog post on the index
    # and RSS feed.
    #
    # Defaults to true
    config_accessor(:show_post_description) { true }


    def default_parser_class
      "Blogit::Parsers::#{default_parser.to_s.classify}Parser".constantize
    end

    # Sets {#disqus_shortname}.
    #   If the user has defined a disqus shortname but hasn't set include_comments to
    #   :disqus will print a warning to the console.
    #
    # shortname - A String with the diquss username to use.
    #
    def disqus_shortname=(shortname)
      return if shortname.blank?
      unless include_comments == :disqus
        blogit_warn "You've set config.disqus_shortname in your blogit config file but " \
         "config.include_comments is not set to :disqus"
      end
      @disqus_shortname = shortname
    end

    # The title to use in the index.rss template. (default: [My Application] Blog
    #   Posts")
    #
    # Returns a String
    def rss_feed_title
      @rss_feed_title ||= "#{rails_app_name} Blog Posts"
    end

    # The description to use in the index.rss template.
    #   (default: "Latest from [My Application]")
    #
    # Returns a String
    def rss_feed_description
      @rss_feed_description ||= "Latest from #{rails_app_name}"
    end



    private


    # The name of this application derived from the app's engine name.
    #   If your Rails app module is KatanaCode, the application name will be "Katana Code"
    #
    # Returns a String
    def rails_app_name
      Rails.application.engine_name.titleize
    end

    # Print a warning message to $STDOUT with the prefix "[Blogit]: "
    #
    # Examples
    #
    #  blogit_warn("Blogit is not a toy!")
    #  # => "[Blogit]: Blogit is not a toy!"
    #
    def blogit_warn(message)
      warn "[Blogit]: #{message}"
    end

  end

end
