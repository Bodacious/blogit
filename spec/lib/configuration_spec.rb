require "spec_helper"

describe Blogit::Configuration do

  let(:blog_configuration) { @blog_configuration = Blogit::Configuration.new }

  it "should set :include_comments to :active_record" do
    blog_configuration.include_comments.should == :active_record
  end

  it "should set :disqus_shortname to blank" do
    blog_configuration.disqus_shortname.should == ""
  end

  it "should print a warning to the console if disqus_shortname is set but include_comments is not disqus" do
    blog_configuration.expects(:warn)
    blog_configuration.include_comments = :active_record
    blog_configuration.disqus_shortname = "bodacious"
  end

  it "should print a warning to the console if twitter_username is set but include_share_bar is false" do
    blog_configuration.expects(:warn)
    blog_configuration.include_share_bar = false
    blog_configuration.twitter_username = "bodacious"
  end

  it "should set :include_share_bar to false" do
    blog_configuration.include_share_bar.should == false
  end

  it "should set :twitter_username to blank" do
    blog_configuration.twitter_username.should == ""
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

  it "should set include admin links to true" do
    blog_configuration.include_admin_links.should be_true
  end

  it "should set page caching to false by default" do
    blog_configuration.cache_pages.should be_false
  end

  it "should set default_parser to :markdown" do
    blog_configuration.default_parser.should eql(:markdown)
  end

  it "should return default_parser as class with default_parser_class" do
    blog_configuration.default_parser = :textile
    blog_configuration.default_parser_class.should eql(Blogit::Parsers::TextileParser)
  end

  it "should set redcarpet default options" do
    blog_configuration.redcarpet_options.should ==
      {
        hard_wrap: true,
        filter_html: true,
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        gh_blockcode: true
      }
  end
  
  it "should set the Pingr mode to :test unless Rails env is production" do
    Pingr.mode.should eql(:test)
  end

  it "should set highlight_code_syntax to true" do
    blog_configuration.highlight_code_syntax.should be_true
  end

  it "should set rss_feed_title to 'Rails engine name Blog Posts'" do
    blog_configuration.rss_feed_title.should eql "#{Rails.application.engine_name.titleize} Blog Posts"
  end

  it "should set rss_feed_description to 'Rails engine name Blog Posts'" do
    blog_configuration.rss_feed_description.should eql "#{Rails.application.engine_name.titleize} Blog Posts"
  end

end