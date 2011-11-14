class ::MarkdownFormatter

  require "nokogiri"

  def initialize(content)
    @content = content
  end

  def parsed
    syntax_highlighter Redcarpet.new(@content, *Blogit.configuration.redcarpet_options).to_html
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end  
  
end
