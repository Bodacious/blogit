require "spec_helper"

describe Blog do
  
  it "should allow developers to set configurations with a block" do
    initial_value = Blog.configuration.current_blogger_method
    Blog.configure do |config| 
      config.current_blogger_method = :logged_in_user
    end
    user_set_value = Blog.configuration.current_blogger_method
    initial_value.should_not eql(user_set_value)
  end
  
  after :all do
    Blog.configure do |config|
      config.inspect
    end
  end
  
end