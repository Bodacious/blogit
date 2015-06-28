# Create a custom renderer that allows highlighting of code blocks
class Redcarpet::Render::HTMLWithAlbino < Redcarpet::Render::HTML

  def block_code(code, language)
    # Albino.colorize(code, language)
    require "pygmentize"
    Pygmentize.process(code, language.to_sym)
  end

end
