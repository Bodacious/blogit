def mock_login
  @current_blogger = User.first || create(:user)
  controller.expects(:current_user).at_least_once.returns(@current_blogger)
end
def reset_configuration
  Blogit.configure do |config|
    config.current_blogger_method = :current_user
  end
end