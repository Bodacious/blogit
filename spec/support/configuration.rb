def reset_configuration
  Blogit.configure do |config|
    config.current_blogger_method = :current_user
  end
end