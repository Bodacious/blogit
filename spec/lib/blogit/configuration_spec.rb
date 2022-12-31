require "rails_helper"

describe Blogit::Configuration do
  let(:blog_configuration) { @blog_configuration = described_class.new }

  it "sets :include_comments to :active_record" do
    expect(blog_configuration.include_comments).to eq(:active_record)
  end

  it "sets :disqus_shortname to blank" do
    expect(blog_configuration.disqus_shortname).to be_nil
  end

  it "prints a warning to the console if disqus_shortname is set but include_comments is not disqus" do
    pending "This spec isn't actually asserting STDOUT was written to"
    blog_configuration.expects(:warn)
    blog_configuration.include_comments = :active_record
    blog_configuration.disqus_shortname = "bodacious"
  end

  it "sets :include_share_bar to false" do
    expect(blog_configuration.include_share_bar).to be(true)
  end

  it "sets :twitter_username to blank" do
    expect(blog_configuration.twitter_username).to be_nil
  end

  it "sets :current_blogger_method to :current_user" do
    expect(blog_configuration.current_blogger_method).to be(:current_user)
  end

  it "sets :blogger_display_name_method to :username" do
    expect(blog_configuration.blogger_display_name_method).to be(:username)
  end

  it "sets :posts_per_page to 5" do
    expect(blog_configuration.posts_per_page).to be(5)
  end


  it "sets datetime format to :short" do
    expect(blog_configuration.datetime_format).to eq(:short)
  end

  it "sets ajax comments to true" do
    expect(blog_configuration.ajax_comments).to be_truthy
  end

  it "sets default_parser to :markdown" do
    expect(blog_configuration.default_parser).to be(:markdown)
  end

  it "returns default_parser as class with default_parser_class" do
    blog_configuration.default_parser = :textile
    expect(blog_configuration.default_parser_class).to eql(Blogit::Parsers::TextileParser)
  end

  it "sets highlight_code_syntax to true" do
    expect(blog_configuration.highlight_code_syntax).to be_truthy
  end

  it "sets rss_feed_title to 'Rails engine name Blog Posts'" do
    expect(blog_configuration.rss_feed_title).to eql "Dummy Application Blog Posts"
  end

  it "sets rss_feed_description to 'Rails engine name Blog Posts'" do
    expect(blog_configuration.rss_feed_description).to eql "Latest from Dummy Application"
  end

  it "sets layout to nil by default" do
    expect(blog_configuration.layout).to be_nil
  end

  it "allows layout to be set to a string" do
    expect { blog_configuration.layout = "custom" }.not_to raise_error
  end

  it "sets active_states default options" do
    expect(blog_configuration.active_states).to eql([:published])
  end

  it "sets hidden_states default options" do
    expect(blog_configuration.hidden_states).to eql(%i(draft archive))
  end
end
