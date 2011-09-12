require "spec_helper"

describe Blog::Blogs do
  
  it "should be included in ActiveRecord::Base" do
    ActiveRecord::Base.included_modules.should include(Blog::Blogs)
  end
  
  describe :blogs do
    it "should be a class macro to AR Base" do
      ActiveRecord::Base.methods.should include(:blogs)
    end
    
    
    it "should build a hm assosciation on the model it's called in" do
      lambda { User.new.blog_posts }.should_not raise_exception(NoMethodError)
      User.new.blog_posts.should be_an(Array)
    end
        
  end

  
end