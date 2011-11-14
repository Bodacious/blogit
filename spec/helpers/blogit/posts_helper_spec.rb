require "spec_helper"

describe Blogit::PostsHelper do
  
  describe "format_content" do
        
    it "should convert markdown text to html if conf is :markdown" do
      Blogit.configure { |c| c.default_formatter = :markdown }
      helper.format_content("## Hello\n\nWorld").should match(/<h2>Hello<\/h2>\n\n<p>World<\/p>/)
    end
    
    it "should convert textile text to html if conf is :textile" do
      Blogit.configure { |c| c.default_formatter = :textile }
      helper.format_content("h1. Hello\n\nWorld").should == "<h1>Hello</h1>\n<p>World</p>"
    end

    it "should convert html text to html if conf is :html" do
      Blogit.configure { |c| c.default_formatter = :html }
      helper.format_content("<h1>Hello</h1>\n\n<p>World</p>").should == "<h1>Hello</h1>\n\n<p>World</p>"
    end

    
  end
  
  describe :blog_post_tag do
    
    it "should create a tag element and give it a 'blog_post... prefixed class" do
      helper.blog_post_tag(:div, "hello", id: "blog_div", class: "other_class").should == %{<div class="other_class blog_post_div" id="blog_div">hello</div>}
      helper.blog_post_tag(:li, "hello", id: "blog_li").should == %{<li class="blog_post_li" id="blog_li">hello</li>}      
    end
    
  end
  
end