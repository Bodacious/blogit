require "spec_helper"

describe Blog::Configuration do
  
  let(:blog_configuration) { @blog_configuration = Blog::Configuration.new }
  
  it "should set :include_comments to true" do
    blog_configuration.include_comments.should be_true
  end

  it "should set :current_blogger_method to :current_user" do
    blog_configuration.current_blogger_method.should eql(:current_user)
  end
  
  it "should set :blogger_display_name_method to :username" do
    blog_configuration.blogger_display_name_method.should eql(:username)
  end
  
  it "should set :posts_per_page to 5" do
    blog_configuration.posts_per_page.should eql(5)
  end
  
  it "should set :authentication_method to :login_required" do
    blog_configuration.authentication_method.should == :login_required
  end
  
  it "should set datetime format to :short" do
    blog_configuration.datetime_format.should == :short
  end
  
end