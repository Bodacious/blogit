require "rails_helper"

describe Blogit::ApplicationHelper do

  describe "format_content" do
    it "should convert markdown text to html if conf is :markdown" do
      Blogit.configure { |c| c.default_parser = :markdown }
      expect(helper.format_content("## Hello\n\nWorld")).to match(/<h2>Hello<\/h2>\n\n<p>World<\/p>/)
    end

    it "should convert textile text to html if conf is :textile" do
      Blogit.configure { |c| c.default_parser = :textile }
      expect(helper.format_content("h1. Hello\n\nWorld")).to eq("<h1>Hello</h1>\n<p>World</p>")
    end

    it "should leave html text as html if conf is :html" do
      Blogit.configure { |c| c.default_parser = :html }
      string = "<h1>Hello</h1>\n\n<p>World</p>"
      expect(helper.format_content(string)).to eq(string)
    end
  end

  describe "actions" do
    it "should create a div with class 'actions'" do
      expect(helper.actions do
        "hello"
      end).to eq(%{<div class="actions">hello</div>})
    end
  end

end