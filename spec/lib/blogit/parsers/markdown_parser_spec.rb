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

    context "when highlight_code_syntax is true" do
      
      before do
        Blogit::configuration.highlight_code_syntax = true
      end
      
      it "should raise an exception if pygments isn't installed" do
        original_path = ENV['PATH']
        ENV['PATH']   = ""
        expect { parser.parsed }.to raise_error
        ENV["PATH"] = original_path
      end
      
      it "should highlight code syntax" do
        parser.parsed.should =~
        Regexp.new("<h2>Header</h2>\n<div class=\"highlight\"><pre><span class=\"nb\">puts</span> <span class=\"s1\">&#39;hello world&#39;</span>\n</pre>\n</div>\n")
      end
      
    end

    context "when highlight_code_syntax is false" do
      
      before do
        Blogit::configuration.highlight_code_syntax = false
      end
      
      it "should not raise an exception, even if pygments isn't installed" do
        original_path = ENV['PATH']
        ENV['PATH']   = ""
        expect { parser.parsed }.to_not raise_error
        ENV["PATH"] = original_path
      end
      
      it "shoud not highlight code" do
        parser.parsed.should == "<h2>Header</h2>\n\n<pre><code class=\"ruby\">puts &#39;hello world&#39;\n</code></pre>\n"
      end
      
    end

  end

end