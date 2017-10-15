require "rails_helper"

describe Blogit::Parsers::MarkdownParser do

  let(:parser) { Blogit::Parsers::MarkdownParser.new("## Some textile\n\nA paragraph") }
  let(:desired_output) { Regexp.new("<h2>Some textile</h2>\n\n<p>A paragraph</p>\n") }

  it "should return an html string of content passed when calling parsed" do
    expect(parser.parsed).to match(desired_output)
  end

  describe "code highlighting" do

    let(:parser) {
      Blogit::Parsers::MarkdownParser.new("## Header\n\n``` ruby\nputs 'hello world'\n```")
    }

    context "when highlight_code_syntax is true" do

      before do
        Blogit::configuration.highlight_code_syntax = true
      end

      # it "should raise an exception if pygments isn't installed" do
      #   original_path = ENV['PATH']
      #   ENV['PATH']   = ""
      #   expect { parser.parsed }.to raise_error(RuntimeError)
      #   ENV["PATH"] = original_path
      # end

      it "should highlight code syntax" do
        expect(Nokogiri::HTML(parser.parsed).at_css(".highlight pre span.nb")).to be_present
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
        expect(parser.parsed).to eq("<h2>Header</h2>\n\n<pre><code class=\"ruby\">puts &#39;hello world&#39;\n</code></pre>\n")
      end

    end

  end

end