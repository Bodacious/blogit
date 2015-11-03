module Blogit::Renderers
  def self.choose_highlight_renderer
    case Blogit::configuration.syntax_highlighter
    when :albino
      require "blogit/renderers/html_with_albino"
      Redcarpet::Render::HTMLWithAlbino
    when :pygments
      require "blogit/renderers/html_with_pygments"
      Redcarpet::Render::HTMLWithPygments
    else
      raise Blogit::ConfigurationError,
        "'#{Blogit.configuration.syntax_highlighter}' is not a valid renderer"
    end
  end
end
