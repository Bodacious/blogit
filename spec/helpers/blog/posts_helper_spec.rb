require "spec_helper"

describe Blog::PostsHelper do
  
  describe "markdown" do
    
    let(:markdown_output) { helper.markdown("# Hello\n\nWorld") }
    
    it "should convert markdown text to html" do
      markdown_output.should == "<h1>Hello</h1>\n\n<p>World</p>\n"
    end
    
    it "should be html_safe" do
      markdown_output.should be_html_safe
    end
    
  end
  
  describe :blog_post_tag do
    
    it "should create a tag element and give it a 'blog_post... prefixed class" do
      helper.blog_post_tag(:div, "hello", id: "blog_div", class: "other_class").should == %{<div class="other_class blog_post_div" id="blog_div">hello</div>}
      helper.blog_post_tag(:li, "hello", id: "blog_li").should == %{<li class="blog_post_li" id="blog_li">hello</li>}      
    end
    
  end
  
end