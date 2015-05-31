require "rails_helper"

describe Blogit::ApplicationHelper do

  describe "blog_tag" do
    
    subject { helper.blog_tag(:li, "hello", id: "blog_li", class: "other_class") }
    
    it "creates a tag element and give it a 'blog_post... prefixed class" do
      expect(subject).to have_class("blog_post_li")
    end
    
    it "adds other classes too" do
      expect(subject).to have_class("other_class")
    end


  end
  
  context "when the :type option is set" do
    
    subject { 
      helper.blog_tag(:div, "helo", id: "blog_div", type: "comment", class: "other_class") 
    }
    
    it "replaces 'post' with :type in the class name" do      
      expect(subject).to have_class("blog_comment")
    end 
    
  end
  

  describe "format_content" do
    it "should convert markdown text to html if conf is :markdown" do
      Blogit.configure { |c| c.default_parser = :markdown }
      expect(helper.format_content("## Hello\n\nWorld")).to match(/<h2>Hello<\/h2>\n\n<p>World<\/p>/)
    end

    it "should convert textile text to html if conf is :textile" do
      Blogit.configure { |c| c.default_parser = :textile }
      expect(helper.format_content("h1. Hello\n\nWorld")).to eq("<h1>Hello</h1>\n<p>World</p>")
    end

    it "should convert html text to html if conf is :html" do
      Blogit.configure { |c| c.default_parser = :html }
      expect(helper.format_content("<h1>Hello</h1>\n\n<p>World</p>")).to eq("<h1>Hello</h1>\n\n<p>World</p>")
    end
  end

  describe "actions" do
    it "should create a div with class 'actions'" do
      expect(helper.actions do
        "hello"
      end).to eq(%{<div class="actions">hello</div>})
    end
  end

  describe "main app's named routes" do
    # rspec generates a helper by mixin in the tested helper and the application
    # helper. But this is not what is being done by rails inside an engine.
    # This mockery is more like the real thing
    class MainAppApplicationHelperBench
      def dummy_thing_path
        "/dummy_thing"
      end
      def dummy_thing_url
        "http://host/dummy_thing"
      end
      def secret
      end
    end
    class BlogitApplicationHelperBench
      include Blogit::ApplicationHelper

      def main_app
        MainAppApplicationHelperBench.new
      end
    end

    let(:raw_helper) { BlogitApplicationHelperBench.new }

    it "should not know named routes of the main app if not configured" do
      Blogit.configure {|c| c.inline_main_app_named_routes = false }

      expect { raw_helper.dummy_thing_path }.to raise_error(NoMethodError)
      expect { raw_helper.dummy_thing_url }.to raise_error(NoMethodError)
    end

    it "should know named routes of the main app" do
      Blogit.configure {|c| c.inline_main_app_named_routes = true }

      expect(raw_helper.dummy_thing_path).to eq("/dummy_thing")
      expect(raw_helper.dummy_thing_url).to eq("http://host/dummy_thing")
    end

    it "should not know anything but named routes of the main app" do
      Blogit.configure {|c| c.inline_main_app_named_routes = true }

      expect { raw_helper.secret }.to raise_error(NoMethodError)
    end

    it "should not know other routes" do
      Blogit.configure {|c| c.inline_main_app_named_routes = true }

      expect { raw_helper.junk_path }.to raise_error(NoMethodError)
      expect { raw_helper.junk_url }.to raise_error(NoMethodError)
    end

  end
end
