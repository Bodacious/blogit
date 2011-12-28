class Blogit::Parsers::MarkdownParser
  
  require "nokogiri"
  require "albino"
  require "blogit/renderers"
  
  def initialize(content)
    @content = content
  end

  def parsed
    renderer = Blogit::configuration.highlight_code_syntax ?  Redcarpet::Render::HTMLWithAlbino : Redcarpet::Render::HTML
    markdown = Redcarpet::Markdown.new(renderer, Blogit.configuration.redcarpet_options)
    html_content = markdown.render(@content).html_safe
  end

  private

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      puts "/"
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.inner_html
  end  

end
