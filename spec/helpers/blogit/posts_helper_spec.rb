require "spec_helper"

describe Blogit::PostsHelper do
  
  describe :blog_post_tag do
    
    it "should create a tag element and give it a 'blog_post... prefixed class" do
      helper.blog_post_tag(:div, "hello", id: "blog_div", class: "other_class").should == %{<div class="other_class blog_post_div" id="blog_div">hello</div>}
      helper.blog_post_tag(:li, "hello", id: "blog_li").should == %{<li class="blog_post_li" id="blog_li">hello</li>}      
    end
    
  end
  
end