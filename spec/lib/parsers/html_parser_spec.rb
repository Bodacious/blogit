require "spec_helper"

describe Blogit::Parsers::HtmlParser do
  
  let(:parser) { Blogit::Parsers::TextileParser.new("<h2>Some textile</h2>\n<p>A paragraph</p>") }
  let(:desired_output) { "<h2>Some textile</h2>\n<p>A paragraph</p>" }
  
  it "should return an html string of content passed when calling parsed" do
    parser.parsed.should == desired_output
  end
  
end