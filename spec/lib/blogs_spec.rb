require "spec_helper"

describe Blogit::Blogs do
  
  it "should be included in ActiveRecord::Base" do
    expect(ActiveRecord::Base.included_modules).to include(Blogit::Blogs)
  end
  
  describe :blogs do
    it "should be a class macro to AR Base" do
      expect(ActiveRecord::Base.methods).to include(:blogs)
    end
        
  end

  
end