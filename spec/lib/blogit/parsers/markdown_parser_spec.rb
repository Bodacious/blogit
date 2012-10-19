require "spec_helper"

describe Blogit::Parsers::MarkdownParser do

  let(:parser) { Blogit::Parsers::MarkdownParser.new("## Some textile\n\nA paragraph") }
  let(:desired_output) { Regexp.new("<h2>Some textile</h2>\n\n<p>A paragraph</p>\n") }

  it "should return an html string of content passed when calling parsed" do
    parser.parsed.should =~ desired_output
  end

  describe "code highlighting" do

    let(:parser) {
      Blogit::Parsers::MarkdownParser.new("## Header\n\n``` ruby\nputs 'hello world'\n```")
    }

    it "requires pymentize to run" do
      system("pygmentize > /dev/null").should equal(true), "It seems that pygmentize is not installed on your system"
    end

    it "should highlight code if highlight_code_syntax is true" do
      Blogit::configuration.highlight_code_syntax = true
      parser.parsed.should =~
      Regexp.new("<h2>Header</h2>\n<div class=\"highlight\"><pre><span class=\"nb\">puts</span> <span class=\"s1\">&#39;hello world&#39;</span>\n</pre>\n</div>\n")
    end

    it "shoud not highlight code if highlight_code_syntax is false" do
      Blogit.configuration.highlight_code_syntax = false
      parser.parsed.should == "<h2>Header</h2>\n\n<pre><code class=\"ruby\">puts &#39;hello world&#39;\n</code></pre>\n"
    end

  end

end
