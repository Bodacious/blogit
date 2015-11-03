# These configuration options can be used to customise the behaviour of Blogit
Blogit.configure do |config|

  # What kind of comments do you want to add to your blog ? (:active_record, :disqus or :no)
  config.include_comments = :active_record

  # When using disqus comments, what is the shortname of your forum ?
  config.disqus_shortname = "YOURUSERNAME"

  # Should there be a share bar on every post ?
  config.include_share_bar = true

  # Twitter username used in the share bar
  config.twitter_username = "@YOURUSERNAME"

  # What method do we call on blogger to show who they are?
  config.blogger_display_name_method = :username

  # Which DateTime::FORMATS format do we use to display blog and comment publish time
  config.datetime_format = :short

  # No. of posts to show per page
  config.posts_per_page = 5

  # If set to true, the comments form will POST and DELETE to the comments
  # controller using AJAX calls.
  config.ajax_comments = true

  # The default format for parsing the blog content.
  config.default_parser = :markdown

  # If blog content contains code, this should be highlighted using
  # one of the renderers.
  config.highlight_code_syntax = true

  # The syntax highlighter to use when highlight_code_syntax is set.
  config.syntax_highlighter = :albino

  # RSS Feed title content
  config.rss_feed_title = "#{Rails.application.engine_name.titleize} Blog Posts"

  # RSS Feed description content
  config.rss_feed_description = "Latest from #{Rails.application.engine_name.titleize}"

  # When using redcarpet as content parser, pass these options as defaults.
  # @see here for more options: https://github.com/tanoku/redcarpet
  config.redcarpet_options = {
    hard_wrap: true,
    filter_html: true,
    autolink: true,
    no_intraemphasis: true,
    fenced_code_blocks: true,
    gh_blockcode: true
  }

  # If this is set, Blogit::PostsController will use the layout named here
  config.layout = "application"

  # List of states that will be visible to the public
  config.active_states = [:published]

  # List of states that will hide the posts from the public.
  config.hidden_states = [:draft, :archive]

end
