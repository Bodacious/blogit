class Blogit::Parsers::HtmlParser
  
  # A String containing the content to be parsed
  attr_reader :content
  
  alias_method :parsed, :content

  def initialize(content)
    @parsed = content
  end

end  
