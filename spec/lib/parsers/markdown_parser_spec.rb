require "spec_helper"

describe Blogit::Parsers::MarkdownParser do
  
  let(:parser) { Blogit::Parsers::MarkdownParser.new("## Some textile\n\nA paragraph") }
  let(:desired_output) { "<h2>Some textile</h2>\n\n<p>A paragraph</p>\n" }
  
  it "should return an html string of content passed when calling parsed" do
    parser.parsed.should == desired_output
  end
  
end