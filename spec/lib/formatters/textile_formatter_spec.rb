require "spec_helper"

describe TextileFormatter do
  
  it "should return an html string of content passed when calling parsed" do
    TextileFormatter.new("h2. Some textile").parsed.should == "<h2>Some textile</h2>"
  end
  
end