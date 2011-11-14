class Blogit::Parsers::TextileParser

  require "redcloth"

  def initialize(content)
    @content = content
  end

  def parsed
    RedCloth.new(@content).to_html
  end

end