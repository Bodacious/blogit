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
end