require "spec_helper"

describe Blogit::ApplicationHelper do
  
  describe :actions do
    
    it "should create a div with class 'actions'" do
      helper.actions do
        "hello"
      end.should == %{<div class="actions">hello</div>}
    end
    
  end
end