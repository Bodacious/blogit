require "spec_helper"

describe Blogit::Parsers::TextileParser do
  let(:parser) { described_class.new("h2. Some textile\n\np. A paragraph") }
  let(:desired_output) { "<h2>Some textile</h2>\n<p>A paragraph</p>" }

  it "returns an html string of content passed when calling parsed" do
    expect(parser.parsed).to eq(desired_output)
  end
end
