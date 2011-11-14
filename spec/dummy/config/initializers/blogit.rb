# These configuration options can be used to customise the behaviour of Blogit
Blogit.configure do |config|
  
  # Should we include comments for blog posts?
  config.include_comments = true

  # The name of the controller method we'll call to return the current blogger.
  config.current_blogger_method = :current_user

  # what method do we call on blogger to return their display name?
  # Defaults to :username
  config.blogger_display_name_method = :username

  # Which DateTime::FORMATS format do we use to display 
  # blog and comment publish time
  config.datetime_format = :short

  # No. of posts to show per page
  config.posts_per_page = 5

  # The name of the before filter we'll call to authenticate the current user.
  config.authentication_method = :login_required

  # If set to true, the comments form will POST and DELETE to the comments 
  # controller using AJAX calls.
  config.ajax_comments = true

  # If set to true, the create, edit, update and destroy actions
  # will be included. If set to false, you'll have to set these 
  # yourself elsewhere in the app
  config.include_admin_actions = true

  # The default format for parsing the blog content.
  config.default_parser = :markdown

  # When using redcarpet as content parser, pass these options as defaults
  config.redcarpet_options = [:hard_wrap, :filter_html, :autolink, 
    :no_intraemphasis, :fenced_code, :gh_blockcode]
  
end