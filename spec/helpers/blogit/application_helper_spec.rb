require "spec_helper"

describe Blogit::ApplicationHelper do

  describe "format_content" do

    it "should convert markdown text to html if conf is :markdown" do
      Blogit.configure { |c| c.default_parser = :markdown }
      helper.format_content("## Hello\n\nWorld").should match(/<h2>Hello<\/h2>\n\n<p>World<\/p>/)
    end

    it "should convert textile text to html if conf is :textile" do
      Blogit.configure { |c| c.default_parser = :textile }
      helper.format_content("h1. Hello\n\nWorld").should == "<h1>Hello</h1>\n<p>World</p>"
    end

    it "should convert html text to html if conf is :html" do
      Blogit.configure { |c| c.default_parser = :html }
      helper.format_content("<h1>Hello</h1>\n\n<p>World</p>").should == "<h1>Hello</h1>\n\n<p>World</p>"
    end


  end

  describe :actions do

    it "should create a div with class 'actions'" do
      helper.actions do
        "hello"
      end.should == %{<div class="actions">hello</div>}
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

      lambda { raw_helper.dummy_thing_path }.should raise_error(NoMethodError)
      lambda { raw_helper.dummy_thing_url }.should raise_error(NoMethodError)
    end

    it "should know named routes of the main app" do
      Blogit.configure {|c| c.inline_main_app_named_routes = true }

      raw_helper.dummy_thing_path.should == "/dummy_thing"
      raw_helper.dummy_thing_url.should == "http://host/dummy_thing"
    end

    it "should not know anything but named routes of the main app" do
      Blogit.configure {|c| c.inline_main_app_named_routes = true }

      lambda { raw_helper.secret }.should raise_error(NoMethodError)
    end

    it "should not know other routes" do
      Blogit.configure {|c| c.inline_main_app_named_routes = true }

      lambda { raw_helper.junk_path }.should raise_error(NoMethodError)
      lambda { raw_helper.junk_url }.should raise_error(NoMethodError)
    end

  end
end
