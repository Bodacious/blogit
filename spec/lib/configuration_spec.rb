require "spec_helper"

describe Blogit::Configuration do

  let(:blog_configuration) { @blog_configuration = Blogit::Configuration.new }

  it "should set :include_comments to :active_record" do
    expect(blog_configuration.include_comments).to eq(:active_record)
  end

  it "should set :disqus_shortname to blank" do
    expect(blog_configuration.disqus_shortname).to eq("")
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
    expect(blog_configuration.include_share_bar).to eq(false)
  end

  it "should set :twitter_username to blank" do
    expect(blog_configuration.twitter_username).to eq("")
  end

  it "should set :current_blogger_method to :current_user" do
    expect(blog_configuration.current_blogger_method).to eql(:current_user)
  end

  it "should set :blogger_display_name_method to :username" do
    expect(blog_configuration.blogger_display_name_method).to eql(:username)
  end

  it "should set :posts_per_page to 5" do
    expect(blog_configuration.posts_per_page).to eql(5)
  end


  it "should set datetime format to :short" do
    expect(blog_configuration.datetime_format).to eq(:short)
  end

  it "should set ajax comments to true" do
    expect(blog_configuration.ajax_comments).to be_truthy
  end

  it "should set default_parser to :markdown" do
    expect(blog_configuration.default_parser).to eql(:markdown)
  end

  it "should return default_parser as class with default_parser_class" do
    blog_configuration.default_parser = :textile
    expect(blog_configuration.default_parser_class).to eql(Blogit::Parsers::TextileParser)
  end

  it "should set redcarpet default options" do
    expect(blog_configuration.redcarpet_options).to eq(
      {
        hard_wrap: true,
        filter_html: true,
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        gh_blockcode: true
      }
    )
  end

  it "should set the Pingr mode to :test unless Rails env is production" do
    expect(Pingr.mode).to eql(:test)
  end

  it "should set highlight_code_syntax to true" do
    expect(blog_configuration.highlight_code_syntax).to be_truthy
  end

  it "should set rss_feed_title to 'Rails engine name Blog Posts'" do
    expect(blog_configuration.rss_feed_title).to eql "#{Rails.application.engine_name.titleize} Blog Posts"
  end

  it "should set rss_feed_description to 'Rails engine name Blog Posts'" do
    expect(blog_configuration.rss_feed_description).to eql "#{Rails.application.engine_name.titleize} Blog Posts"
  end

  it "should set layout to nil by default" do
    expect(blog_configuration.layout).to be_nil
  end

  it "should allow layout to be set to a string" do
    expect { blog_configuration.layout = "custom" }.not_to raise_error
  end

  it 'should set active_states default options' do
    expect(blog_configuration.active_states).to eql([:published])
  end

  it 'should set hidden_states default options' do
    expect(blog_configuration.hidden_states).to eql([:draft, :archive])
  end

end