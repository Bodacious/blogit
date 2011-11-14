class Blogit::Parsers::MarkdownParser

  def initialize(content)
    @content = content
  end

  def parsed
    html_content = Redcarpet.new(@content, *Blogit.configuration.redcarpet_options).to_html
    if Blogit::configuration.highlight_code_syntax
      syntax_highlighter(html_content)
    else
      html_content
    end
  end



  require "nokogiri"
  require "albino"

  private

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.inner_html
  end  

end
