# These configuration options can be used to customise the behaviour of Blogit
Blogit.configure do |config|

  # What kind of comments do you want to add to your blog ? (:active_record, :disqus or :no)
  config.include_comments = :active_record

  # When using disqus comments, what is the shortname of your forum ?
  config.disqus_shortname = ""

  # Should there be a share bar on every post ?
  config.include_share_bar = true

  # Twitter username used in the share bar
  config.twitter_username = "blogit"

  # The name of the controller method we'll call to return the current blogger.
  # Change this if you use something other than current_user.
  # Eg. current_admin_user (if using ActiveAdmin)
  config.current_blogger_method = :current_user

  # What method do we call on blogger to show who they are?
  config.blogger_display_name_method = :username

  # Which DateTime::FORMATS format do we use to display blog and comment publish time
  config.datetime_format = :short

  # Should the controllers cache the blog pages as HTML?
  config.cache_pages = true

  # No. of posts to show per page
  config.posts_per_page = 5

  # The name of the before filter we'll call to authenticate the current user.
  config.authentication_method = :login_required

  # If set to true, the comments form will POST and DELETE to the comments
  # controller using AJAX calls.
  config.ajax_comments = true

  # If set to true, the create, edit, update and destroy actions
  # will be included. If set to false, you'll have to set these
  # yourself elsewhere in the app.
  config.include_admin_actions = true

  # If set to true, links for new posts, editing posts and deleting comments
  # will be available. If set to false, you'll have to set these
  # yourself in the templates.
  config.include_admin_links = true

  # The default format for parsing the blog content.
  config.default_parser = :textile

  # If blog content contains code, this should be highlighted using
  # albino.
  config.highlight_code_syntax = true

  # When using redcarpet as content parser, pass these options as defaults.
  # @see here for more options: https://github.com/tanoku/redcarpet
  # config.redcarpet_options = [:hard_wrap, :filter_html, :autolink,
  #   :no_intraemphasis, :fenced_code, :gh_blockcode]

end
