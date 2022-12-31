require "rails_helper"

describe Blogit::Parsers::MarkdownParser do
  let(:parser) { described_class.new("## Some textile\n\nA paragraph") }
  let(:desired_output) { Regexp.new("<h2>Some textile</h2>\n\n<p>A paragraph</p>\n") }

  it "returns an html string of content passed when calling parsed" do
    expect(parser.parsed).to match(desired_output)
  end

  describe "code highlighting" do
    let(:parser) do
      described_class.new("## Header\n\n``` ruby\nputs 'hello world'\n```")
    end

    it "requires pymentize to run" do
      expect(system("which pygmentize")).not_to eql(false),
        "It seems that pygmentize is not installed on your system"
    end

    context "when highlight_code_syntax is true" do
      before do
        Blogit::configuration.highlight_code_syntax = true
      end

      it "raises an exception if pygments isn't installed" do
        original_path = ENV.fetch("PATH", nil)
        ENV["PATH"]   = ""
        expect { parser.parsed }.to raise_error(RuntimeError)
        ENV["PATH"] = original_path
      end

      it "highlights code syntax" do
        expect(parser.parsed).to include(%(<div class="highlight"><pre>))
      end
    end

    context "when highlight_code_syntax is false" do
      before do
        Blogit::configuration.highlight_code_syntax = false
      end

      it "does not raise an exception, even if pygments isn't installed" do
        original_path = ENV.fetch("PATH", nil)
        ENV["PATH"]   = ""
        expect { parser.parsed }.not_to raise_error
        ENV["PATH"] = original_path
      end

      it "shoud not highlight code" do
        expect(parser.parsed).to eq("<h2>Header</h2>\n\n<pre><code class=\"ruby\">puts &#39;hello world&#39;\n</code></pre>\n")
      end
    end
  end
end
