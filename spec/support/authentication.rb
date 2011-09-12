def mock_login
  @current_blogger = build(:user)
  controller.expects(:current_user).at_least_once.returns(@current_blogger)
end

def reset_configuration
  Blog.configure do |config|
    config.current_blogger_method = :current_user
  end
end