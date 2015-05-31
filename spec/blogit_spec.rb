require "spec_helper"

describe Blogit do
  
  it "allows developers to set configurations with a block" do
    initial_value = Blogit.configuration.current_blogger_method
    Blogit.configure do |config| 
      config.current_blogger_method = :logged_in_user
    end
    user_set_value = Blogit.configuration.current_blogger_method
    expect(initial_value).not_to eql(user_set_value)
  end
  
  after :all do
    Blogit.configure do |config|
      config.inspect
    end
  end
  
end