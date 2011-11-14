require "spec_helper"

describe Blogit::Configuration do
  
  let(:blog_configuration) { @blog_configuration = Blogit::Configuration.new }
  
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
  
  it "should set author_edits_only to false" do
    blog_configuration.author_edits_only.should be_false
  end
  
  it "should set ajax comments to true" do
    blog_configuration.ajax_comments.should be_true
  end
  
  it "should set include admin actions to true" do
    blog_configuration.include_admin_actions.should be_true
  end

  it "should set default_formatter to MarkdownParser" do
    blog_configuration.default_formatter.should eql(MarkdownParser)
  end
  
  it "should classify default_formatter when set" do
    blog_configuration.default_formatter = :textile
    blog_configuration.default_formatter.should eql(TextileParser)
  end
  
  it "should set redcarpet default options" do
    blog_configuration.redcarpet_options.should == 
      [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
  end
  
end