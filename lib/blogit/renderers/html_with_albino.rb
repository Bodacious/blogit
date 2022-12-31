# Create a custom renderer that allows highlighting of code blocks
class Redcarpet::Render::HTMLWithAlbino < Redcarpet::Render::HTML
  require "albino"

  def block_code(code, language)
    Albino.colorize(code, language)
  end
end
